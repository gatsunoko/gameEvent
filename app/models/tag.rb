class Tag < ApplicationRecord
  belongs_to :event_detail

  validates :title, presence: true, length: { maximum: 20 }
end
