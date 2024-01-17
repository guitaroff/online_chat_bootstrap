class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)
    @new_room = Room.new
  end

  def show
    @room = Room.find_by!(title: params[:title])
    @messages = @room.messages
    @new_message = current_user.messages.build
  end

  def create
    @new_room = current_user.rooms.create!(title: room_params[:title])
  end

  private

  def room_params
    params.require(:room).permit(:title)
  end
end
