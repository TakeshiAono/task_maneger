class Task < ApplicationRecord
  validates :title, presence: true
  validates :priority, presence: true
  validates :deadline, presence: true
  # has_many :status
  # accepts_nested_attributes_for :status
  # belongs_to :user

  def self.status_input_restriction
    [nil, 'done','not_yet','started']
  end

  scope :search, -> (column, search_word){ where("#{column} like ?","%#{search_word}%") }
  # def self.title_search(search_word)
  #   where('title like ?',"%#{search_word}%")
  # end
  
end
