class User < ApplicationRecord
  validates_presence_of :name
  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true, presence: true

  has_secure_password
end