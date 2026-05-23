class SoupQuestion < ApplicationRecord
  belongs_to :user

  has_many :questions, dependent: :destroy
  has_many :soup_question_ratings, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :answer, presence: true

  def average_clarity_score
    soup_question_ratings.average(:clarity_score)&.round(1)
  end

  def average_difficulty_score
    soup_question_ratings.average(:difficulty_score)&.round(1)
  end

  def ratings_count
    soup_question_ratings.count
  end
end