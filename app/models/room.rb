class Room < ApplicationRecord
  has_many :messages
  has_many :users

  # constant
  MAX_ROOM_MEMBER = 2
end
