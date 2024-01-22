require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:messages).dependent(:destroy) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      room = build(:room)
      expect(room).to be_valid
    end

    it 'is not valid without a title' do
      room = build(:room, title: nil)
      expect(room).to_not be_valid
    end
  end

  describe 'scopes' do
    describe '.public_rooms' do
      it 'returns public rooms' do
        public_room = create(:room, is_private: false)
        private_room = create(:room, is_private: true)

        result = Room.public_rooms

        expect(result).to include(public_room)
        expect(result).to_not include(private_room)
      end
    end
  end

  describe '.fetch_private_room' do
    it 'returns an existing private room with the specified title' do
      user = create(:user)
      existing_room = create(:room, user: user, is_private: true)
      room_title = existing_room.title

      result = Room.fetch_private_room(room_title, user)

      expect(result).to eq(existing_room)
    end

    it 'creates a new private room if no existing room is found' do
      user = create(:user)
      room_title = 'New Room'

      result = Room.fetch_private_room(room_title, user)

      expect(result).to be_instance_of(Room)
      expect(result.title).to eq(room_title)
      expect(result.is_private).to eq(true)
    end
  end
end
