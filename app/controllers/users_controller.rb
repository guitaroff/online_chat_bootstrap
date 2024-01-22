class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
 
    @room = Room.fetch_private_room(fetch_room_title(@user, current_user), current_user)
    @messages = @room.messages
    @new_message = current_user.messages.build
  end

  private

  def fetch_room_title(u1, u2)
    users = [u1,u2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end
end
