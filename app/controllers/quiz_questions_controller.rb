class QuizQuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :quiz_from_id, :only=>[:index, :new, :create]
  before_filter :quiz_question_from_id, :only=>[:show, :edit, :update, :destroy]
  # GET /quiz_questions
  # GET /quiz_questions.xml
  def index
    respond_to do |format|
      format.html {redirect_to edit_quiz_path(@quiz)}
      format.xml  { render :xml => @quiz.quiz_questions }
    end
  end

  # GET /quiz_questions/1
  # GET /quiz_questions/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz_question }
    end
  end

  # GET /quiz_questions/new
  # GET /quiz_questions/new.xml
  def new
    @question = Question.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /quiz_questions/1/edit
  def edit
  end

  # POST /quiz_questions
  # POST /quiz_questions.xml
  def create
    @question = Question.new(params[:question])

    respond_to do |format|
      if @question.save
        @quiz_question = QuizQuestion.create!(:quiz=>@quiz, :position=>@quiz.questions.count, :question=>@question)
        format.html { redirect_to(edit_quiz_path(@quiz), :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @quiz_question, :status => :created, :location => @quiz_question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quiz_questions/1
  # PUT /quiz_questions/1.xml
  def update
    @quiz_question = QuizQuestion.find(params[:id])

    respond_to do |format|
      if @quiz_question.update_attributes(params[:quiz_question])
        format.html { redirect_to(@quiz_question, :notice => 'Quiz question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_questions/1
  # DELETE /quiz_questions/1.xml
  def destroy
    @quiz_question = QuizQuestion.find(params[:id])
    @question = @quiz_question.question
    @quiz_question.destroy
    
    @question.destroy if QuizQuestion.where(:question_id=>@question.id).count == 0

    respond_to do |format|
      format.html { redirect_to(edit_quiz_url(@quiz)) }
      format.xml  { head :ok }
    end
  end
  protected
    def quiz_from_id
      logger.debug("Looking up for ID: #{params[:id]}")
      @quiz = Quiz.find(params[:id])
      valid_quiz?      
    end
    def quiz_question_from_id
      @quiz_question = QuizQuestion.find(params[:id])
      raise "Doh" if @quiz_question.nil?
      @quiz = @quiz_question.quiz
      valid_quiz?
    end
    def valid_quiz?
      raise CanCan::AccessDenied.new("No access to this quiz") if @quiz.nil? or @quiz.owner != current_user
      true
    end
end
