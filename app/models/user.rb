class User < ApplicationRecord
  has_many :soup_questions, dependent: :destroy

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def self.find_or_create_from_auth(auth)
    user = find_or_initialize_by(
      provider: auth.provider,
      uid: auth.uid
    )

    user.name = auth.info.name
    user.email = auth.info.email
    user.image_url = auth.info.image

    user.save!
    user
  end
end