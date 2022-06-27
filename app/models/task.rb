class Task < ApplicationRecord
  validates :title, presence: true
  validates :priority, presence: true
  validates :deadline, presence: true
  # belongs_to :user
end
