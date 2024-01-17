class Room < ApplicationRecord
  belongs_to :user
  has_many :messages, -> { sorted }, dependent: :destroy

  after_create_commit { broadcast_append_to "rooms" }

  scope :public_rooms, -> { where(is_private: false) }
end
