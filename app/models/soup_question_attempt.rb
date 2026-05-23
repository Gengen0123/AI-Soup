class SoupQuestionAttempt < ApplicationRecord
  belongs_to :soup_question
  belongs_to :user, optional: true

  has_many :questions, dependent: :destroy

  validates :session_token, presence: true
  validates :session_token, uniqueness: { scope: :soup_question_id }
end