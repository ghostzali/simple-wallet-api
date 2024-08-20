class Session < ApplicationRecord
  belongs_to :user

  validates :token, presence: true, uniqueness: true

  scope :active, -> { where(revoked_at: nil)}
end
