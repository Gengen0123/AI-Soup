class SoupQuestionRating < ApplicationRecord
  belongs_to :soup_question
  belongs_to :user

  validates :clarity_score, presence: true, inclusion: { in: 1..5 }
  validates :difficulty_score, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :soup_question_id }
  validate :author_cannot_rate_own_question

  private

  def author_cannot_rate_own_question
    return if soup_question.blank? || user.blank?

    if soup_question.user_id == user_id
      errors.add(:base, "自分の問題は評価できません")
    end
  end
end