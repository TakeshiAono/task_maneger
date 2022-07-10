class Task < ApplicationRecord
  # PRIORITY_CONST = {"1" => "low", "2" => "middle", "3" => "high"}
  PRIORITY_CONST = {1 => "low", 2 => "middle", 3 => "high" }
  PRIORITY_WORD = ["low" , "middle", "high"]
  # STATUS_WORD = [nil, 'done','not_yet','started']
  validates :title, presence: true
  validates :priority, presence: true, numericality: {less_than_or_equal_to: 3}
  validates :deadline, presence: true
  belongs_to :user
  has_many :groups, dependent: :destroy
  has_many :labels, through: :groups
  # accepts_nested_attributes_for :labels
  # has_many :status
  # belongs_to :user

  def self.status_input_restriction
    I18n.t([nil, 'done','not_yet','started'], scope: [:csv, :header, :task])
  end

  def self.priority_cord
    PRIORITY_CONST
  end

  scope :search, -> (column, search_word){ where("#{column} like ?","%#{search_word}%") }
  # def self.title_search(search_word)
  #   where('title like ?',"%#{search_word}%")
  # end
  
end
