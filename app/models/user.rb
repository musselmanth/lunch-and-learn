class User < ApplicationRecord
  has_many :favorites

  validates_presence_of :name
  validates :email, uniqueness: true, presence: true

  has_secure_password
  has_secure_token :api_key
end