class QuestionsController < ApplicationController
  def create
    @soup_question = SoupQuestion.find(params[:soup_question_id])
    @question = @soup_question.questions.build(question_params)
    @question.answer = generate_answer(@soup_question, @question.body)

    if @question.save
      redirect_to @soup_question
    else
      render "soup_questions/show", status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def generate_answer(soup_question, question_body)
    client = OpenAI::Client.new(
      access_token: ENV.fetch("OPENAI_API_KEY")
    )

    response = client.chat(
      parameters: {
        model: "gpt-4.1-mini",
        messages: [
          {
            role: "system",
            content: "あなたはウミガメのスープの出題者です。質問に対して必ず「はい」「いいえ」「関係ない」のいずれか一語だけで答えてください。説明は禁止です。"
          },
          {
            role: "user",
            content: "問題: #{soup_question.body}\n正解: #{soup_question.answer}\n質問: #{question_body}"
          }
        ]
      }
    )

    answer = response.dig("choices", 0, "message", "content")

    if answer.include?("はい")
      "はい"
    elsif answer.include?("いいえ")
      "いいえ"
    else
      "関係ない"
    end
  end
end