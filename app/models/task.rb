class Task < ApplicationRecord
  validates :title, presence: true
  validates :priority, presence: true
  validates :deadline, presence: true
  # has_many :status
  # accepts_nested_attributes_for :status
  # belongs_to :user

  def self.status_input_restriction
    ['done','not_yet','started']
  end
end
