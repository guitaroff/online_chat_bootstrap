require 'rails_helper'

RSpec.describe RoomsController, type: :request do
  let!(:current_user) { create(:user) }
  let!(:other_user1) { create(:user) }
  let!(:other_user2) { create(:user) }

  let!(:public_room){ create(:room, user: current_user, is_private: false) }
  let!(:private_room){ create(:room, user: current_user, is_private: true) }

  describe 'GET #index' do
    context 'guest user' do
      it 'redirect to home page' do
        get rooms_path

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'logged in user' do
      before do
        sign_in current_user
        get rooms_path
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns public rooms to @rooms' do
        expect(assigns(:rooms)).to include(public_room)
        expect(assigns(:rooms)).to_not include(private_room)
      end

      it 'assigns users except the current user to @users' do
        expect(assigns(:users)).to include(other_user1, other_user2)
        expect(assigns(:users)).to_not include(current_user)
      end

      it 'assigns a new room to @new_room' do
        expect(assigns(:new_room)).to be_instance_of(Room)
      end

      it 'renders the index template' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    context 'guest user' do
      it 'redirect to home page' do
        get room_path(public_room.title)

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'logged in user' do
      let!(:message1) { create(:message, room: public_room, user: current_user) }
      let!(:message2) { create(:message, room: public_room, user: other_user1) }

      before do
        sign_in current_user
        get room_path(public_room.title)
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns the requested room to @room' do
        expect(assigns(:room)).to eq(public_room)
      end

      it 'assigns messages from the room to @messages' do
        expect(assigns(:messages)).to eq([message1, message2])
      end

      it 'assigns a new message to @new_message' do
        expect(assigns(:new_message)).to be_instance_of(Message)
        expect(assigns(:new_message).user).to eq(current_user)
      end

      it 'renders the show template' do
        expect(response).to render_template :show
      end
    end
  end

  describe 'POST #create' do
    let!(:params) { { room: { title: 'New Room' } } }

    context 'guest user' do
      it 'redirect to home page' do
        post rooms_path, params: params

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'logged in user' do
      before { sign_in current_user }

      it 'creates a new room' do
        expect {
          post rooms_path, params: params
        }.to change(Room, :count).by(1)
      end
    end
  end
end
