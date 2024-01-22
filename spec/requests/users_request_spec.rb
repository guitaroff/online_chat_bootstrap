require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let!(:user) { create(:user) }
  let!(:current_user) { create(:user) }
  let!(:private_room) { create(:room, user: current_user, is_private: true) }

  describe 'GET #show' do
    context 'guest user' do
      it 'redirect to home page' do
        get user_path(user)

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'logged in user' do
      before { sign_in current_user }

      it 'returns a success response' do
        get user_path(user)
        expect(response).to have_http_status(:success)
      end

      it 'assigns the requested user to @user' do
        get user_path(user)
        expect(assigns(:user)).to eq(user)
      end

      it 'assigns a new private room to @room' do
        allow(Room).to receive(:fetch_private_room).and_return(private_room)
        get user_path(user)
        
        expect(assigns(:room)).to be_instance_of(Room)
      end

      it 'assigns messages from the room to @messages' do
        allow(Room).to receive(:fetch_private_room).and_return(private_room)
        get user_path(user)
        
        expect(assigns(:messages)).to eq(private_room.messages)
      end

      it 'assigns a new message to @new_message' do
        get user_path(user)

        expect(assigns(:new_message)).to be_instance_of(Message)
        expect(assigns(:new_message).user).to eq(current_user)
      end

      it 'renders the show template' do
        get user_path(user)
        expect(response).to render_template :show
      end
    end
  end
end
