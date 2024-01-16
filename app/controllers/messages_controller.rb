class MessagesController < ApplicationController

  def create
    @new_message = current_user.messages.create!(message_params)

    room = @new_message.room
    @new_message.broadcast_append_to room, target: "room_#{room.id}_messages", locals: { message: @new_message }
  end

  private

  def message_params
    params.require(:message).permit(:body, :room_id)
  end
end
