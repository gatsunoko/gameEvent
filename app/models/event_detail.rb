class EventDetail < ApplicationRecord
  belongs_to :event
  belongs_to :game
  belongs_to :user
end
