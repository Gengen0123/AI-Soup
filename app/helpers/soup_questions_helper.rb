module SoupQuestionsHelper
  def star_rating(score)
    return "未評価" if score.blank?

    rounded_score = score.round
    filled = "★" * rounded_score
    empty = "☆" * (5 - rounded_score)

    filled + empty
  end
end