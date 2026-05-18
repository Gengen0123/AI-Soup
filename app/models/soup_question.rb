class SoupQuestion < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :answer, presence: true
end