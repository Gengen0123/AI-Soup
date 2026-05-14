class SoupQuestion < ApplicationRecord
  has_many :questions, dependent: :destroy
end