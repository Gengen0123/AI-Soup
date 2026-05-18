class Question < ApplicationRecord
  belongs_to :soup_question

  validates :body, presence: true, length: { maximum: 200 }
end