class Room < ApplicationRecord
  belongs_to :user
  has_many :messages, -> { sorted }, dependent: :destroy

  after_create_commit { broadcast_append_to "rooms" }

  scope :public_rooms, -> { where(is_private: false) }

  def self.fetch_room(room_title, user)
    Room.where(title: room_title).first || user.rooms.create!(title: room_title, is_private: true)
  end
end
