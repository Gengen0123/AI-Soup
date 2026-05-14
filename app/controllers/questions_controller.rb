class QuestionsController < ApplicationController
  def create
    @soup_question = SoupQuestion.find(params[:soup_question_id])
    @question = @soup_question.questions.build(question_params)
    @question.answer = generate_answer(@soup_question, @question.body)

    if @question.save
      redirect_to @soup_question
    else
      render "soup_questions/show"
    end
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def generate_answer(soup_question, question_body)
    "はい "
  end

end