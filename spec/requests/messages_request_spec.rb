require 'rails_helper'

RSpec.describe MessagesController, type: :request do
  let!(:current_user) { create(:user) }
  let!(:room) { create(:room, user: current_user) }
  let(:params) { { message: { body: 'Hello!', room_id: room.id } } }

  describe 'POST #create' do
    context 'guest user' do
      it 'redirect to home page' do
        post messages_path, params: params

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'logged in user' do
      before { sign_in current_user }

      context 'with valid params' do
        it 'creates a new message' do
          expect {
            post messages_path, params: params
          }.to change(Message, :count).by(1)

          new_message = Message.last

          expect(response).to have_http_status(:success)
          expect(assigns(:new_message)).to eq(new_message)
        end
      end

      context 'with invalid params' do
        let(:invalid_params) { { message: { body: '', room_id: room.id } } }

        it 'unprocessable entity status' do
          expect {
            post messages_path, params: invalid_params
          }.to_not change(Message, :count)

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
