class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :email, uniqueness: true
  # accepts_nested_attributes_for :tasks
  has_secure_password
end
