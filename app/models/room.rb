class Room < ApplicationRecord
  belongs_to :user
  has_many :messages, -> { sorted }, dependent: :destroy
end
