class SoupQuestionRatingsController < ApplicationController
  before_action :require_login
  before_action :set_soup_question

  def create
    @rating = @soup_question.soup_question_ratings.build(rating_params)
    @rating.user = current_user

    if @rating.save
      redirect_to @soup_question, notice: "評価を投稿しました。"
    else
      redirect_to @soup_question, alert: @rating.errors.full_messages.join("、")
    end
  end

  def update
    @rating = @soup_question.soup_question_ratings.find_by!(user: current_user)

    if @rating.update(rating_params)
      redirect_to @soup_question, notice: "評価を更新しました。"
    else
      redirect_to @soup_question, alert: @rating.errors.full_messages.join("、")
    end
  end

  private

  def set_soup_question
    @soup_question = SoupQuestion.find(params[:soup_question_id])
  end

  def rating_params
    params.require(:soup_question_rating).permit(:clarity_score, :difficulty_score)
  end
end