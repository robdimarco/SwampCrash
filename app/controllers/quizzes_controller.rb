class QuizzesController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit, :update, :destroy, :create, :new]
  
  def answer
    @quiz = Quiz.find(params[:id])
    
    if signed_in?
      @answer_sheet = AnswerSheet.find_or_initialize_by_user_id_and_quiz_id @user, @quiz
      @answer_sheet.answers_hash=@quiz.questions.inject({}){|hsh,q|hsh[q.id] = params[:"question_#{q.id}"];hsh}
    else
      @answer_sheet = AnswerSheet.new :quiz=>@quiz
    end
    respond_to do |format|
      format.html { redirect_to(@quiz, :notice => 'Answers Saved')}
      format.js  { render :text => "OK".to_json }
    end
    
  end
  
  # GET /quizzes
  # GET /quizzes.xml
  def index
    @quizzes = Quiz.find_for_table :all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quizzes }
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.xml
  def show
    @quiz = Quiz.find(params[:id])
    @answer_sheet = AnswerSheet.find_or_initialize_by_user_id_and_quiz_id @user, @quiz
    @answer_sheet.answers_hash = @quiz.questions.inject(@answer_sheet.answers_hash){|hsh,q|hsh[q.id] ||= '';hsh}
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
    @quiz = Quiz.find(params[:id])
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
    @quiz = Quiz.find(params[:id])
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
    @quiz = Quiz.find(params[:id])
    @quiz.destroy

    respond_to do |format|
      format.html { redirect_to(quizzes_url) }
      format.xml  { head :ok }
    end
  end
end
