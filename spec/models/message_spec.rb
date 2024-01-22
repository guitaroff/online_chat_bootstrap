require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:room) { create(:room) }
  let!(:user) { room.user }

  describe 'associations' do
    it { should belong_to(:room) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      message = build(:message, room: room, user: user)
      expect(message).to be_valid
    end

    it 'is not valid without a body' do
      message = build(:message, body: nil, room: room, user: room.user)
      expect(message).to_not be_valid
    end
  end

  describe 'scopes' do
    describe '.sorted' do
      it 'returns messages sorted by id' do
        message1 = create(:message, room: room, user: user)
        message2 = create(:message, room: room, user: user)
        message3 = create(:message, room: room, user: user)

        result = Message.sorted

        expect(result).to eq([message1, message2, message3])
      end
    end
  end
end
