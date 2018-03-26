class User < ApplicationRecord
  validates :username, uniqueness: true
  validates :username, length: { maximum: 15 }
  validates :password, length: { minimum: 5 }
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_secure_password
end
