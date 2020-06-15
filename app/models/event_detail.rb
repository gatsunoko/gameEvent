class EventDetail < ApplicationRecord
  belongs_to :event
  belongs_to :game
  belongs_to :user
  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :tags, allow_destroy: true
  
  validates :owner, presence: true
  validates :title, presence: true
  validates :date, presence: true
  validate  :date_not_before_today
  
  def date_not_before_today
    errors.add(:date, "は今日以降のものを選択してください") if date.nil? || date < Date.today
  end
end
