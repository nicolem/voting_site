class Voter < ApplicationRecord
  belongs_to :candidate, optional: true

  validates :email, uniqueness: true, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
