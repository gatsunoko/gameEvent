class Game < ApplicationRecord
  has_many :events
  has_one_attached :image
end
