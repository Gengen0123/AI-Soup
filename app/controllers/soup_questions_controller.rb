class SoupQuestionsController < ApplicationController
  before_action :set_soup_question, only: %i[ show edit update destroy ]

  # GET /soup_questions or /soup_questions.json
  def index
    @soup_questions = SoupQuestion.all
  end

  # GET /soup_questions/1 or /soup_questions/1.json
  def show
    @question = Question.new
  end

  # GET /soup_questions/new
  def new
    @soup_question = SoupQuestion.new
  end

  # GET /soup_questions/1/edit
  def edit
  end

  # POST /soup_questions or /soup_questions.json
  def create
    @soup_question = SoupQuestion.new(soup_question_params)

    respond_to do |format|
      if @soup_question.save
        format.html { redirect_to @soup_question, notice: "Soup question was successfully created." }
        format.json { render :show, status: :created, location: @soup_question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @soup_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /soup_questions/1 or /soup_questions/1.json
  def update
    respond_to do |format|
      if @soup_question.update(soup_question_params)
        format.html { redirect_to @soup_question, notice: "Soup question was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @soup_question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @soup_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /soup_questions/1 or /soup_questions/1.json
  def destroy
    @soup_question.destroy!

    respond_to do |format|
      format.html { redirect_to soup_questions_path, notice: "Soup question was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_soup_question
      @soup_question = SoupQuestion.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def soup_question_params
      params.expect(soup_question: [ :title, :body, :answer, :explanation ])
    end
end
