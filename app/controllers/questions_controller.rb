class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :quiz_from_id, :only=>[:index, :new, :create]
  before_filter :question_from_id, :only=>[:show, :edit, :update, :destroy]
  # GET /questions
  # GET /questions.xml
  def index
    respond_to do |format|
      format.html {redirect_to edit_quiz_path(@quiz)}
      format.xml  { render :xml => @quiz.questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit; end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    @question.quiz = @quiz

    respond_to do |format|
      if @question.save
        format.html { redirect_to(edit_quiz_path(@quiz), :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(edit_quiz_path(@quiz), :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

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
    def question_from_id
      @question = Question.find(params[:id])
      @quiz = @question.quiz
      valid_quiz?
    end
    def valid_quiz?
      raise CanCan::AccessDenied.new("No access to this quiz") if @quiz.nil? or @quiz.owner != current_user
      true
    end
end
