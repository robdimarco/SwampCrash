class QuizzesController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update, :destroy, :create, :new, :grade_answers]
  before_filter :quiz_from_params, :only=>[:edit, :update, :destroy, :grade_answers, :show, :answer]
  before_filter :must_be_owner!, :only=>[:edit, :update, :destroy, :grade_answers]
  
  def answer
    params_to_use = (session[:answer_sheet] || {}).merge(params)
    params_to_use.symbolize_keys!
    Rails.logger.debug "Using params #{params_to_use.inspect} have id of #{params_to_use[:id]}"
    
    if user_signed_in?
      @answer_sheet = AnswerSheet.find_or_initialize_by_user_id_and_quiz_id current_user.id, @quiz.id
      @answer_sheet.answers_hash=@quiz.questions.inject({}){|hsh,q|hsh[q.id.to_i] = params_to_use[:"answer_#{q.id}"];hsh}
      Rails.logger.debug @answer_sheet.inspect
      @answer_sheet.grade!
      session.delete(:answer_sheet)

      respond_to do |format|
        format.html { redirect_to(@quiz, :notice => 'Your answers have been saved.  We will let you know when everyone has entered and your score is ready.')}
        format.js  { render :text => "OK".to_json }
      end
    else
      session[:answer_sheet] = params_to_use
      session[:redirect_after_sign_in_url] = answer_quiz_path
      redirect_to new_user_session_path
    end
  end
  
  def grade_answers
    @answer_sheet = AnswerSheet.find(params[:answer_sheet_id])
    raise "Invalid ID" if @answer_sheet.nil? or @answer_sheet.quiz != @quiz
    if request.post?
      @answer_sheet.status = 'graded'
      @answer_sheet.answers.each do |a|
        a.update_attributes :correct_answer_id => params[:"question_#{a.question.id}_correct_answer_id"]
      end
        
      @answer_sheet.save
      redirect_to(edit_quiz_path(@quiz), :notice => "Answers for #{@answer_sheet.user} have been graded") 
    end
  end
  
  # GET /quizzes
  # GET /quizzes.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quizzes }
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.xml
  def show
    @answer_sheet = AnswerSheet.find_or_initialize_by_user_id_and_quiz_id( current_user.id, @quiz.id ) if user_signed_in?
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz }
    end
  end

  # GET /quizzes/new
  # GET /quizzes/new.xml
  def new
    @quiz = Quiz.new(:owner=>current_user)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz }
    end
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes
  # POST /quizzes.xml
  def create
    @quiz = Quiz.new(params[:quiz])
    @quiz.owner = current_user
    respond_to do |format|
      if @quiz.save
        format.html { redirect_to(@quiz, :notice => 'Quiz was successfully created.') }
        format.xml  { render :xml => @quiz, :status => :created, :location => @quiz }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quizzes/1
  # PUT /quizzes/1.xml
  def update
    redirect_to root_path and return unless @quiz and @quiz.owner == current_user
    respond_to do |format|
      if @quiz.update_attributes(params[:quiz])
        format.html { redirect_to(@quiz, :notice => 'Quiz was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.xml
  def destroy
    @quiz.destroy

    respond_to do |format|
      format.html { redirect_to(quizzes_url) }
      format.xml  { head :ok }
    end
  end
  private
  def must_be_owner!
    raise "Access Denied!" unless current_user == @quiz.owner
    true
  end
  def quiz_from_params
    @quiz = Quiz.find(params[:id])
  end
end
