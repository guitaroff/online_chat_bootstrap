require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:rooms).dependent(:destroy) }
    it { should have_many(:messages) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end
  end

  describe 'scopes' do
    describe '.all_except' do
      it 'returns users except the specified user_id' do
        user1 = create(:user)
        user2 = create(:user)
        excluded_user = create(:user)

        result = User.all_except(excluded_user.id)

        expect(result).to include(user1, user2)
        expect(result).to_not include(excluded_user)
      end
    end
  end
end
