class Question < ApplicationRecord
  belongs_to :soup_question
  belongs_to :soup_question_attempt, optional: true

  validates :body, presence: true
end