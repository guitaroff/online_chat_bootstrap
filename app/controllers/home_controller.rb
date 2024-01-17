class HomeController < ApplicationController
  skip_before_action :check_auth_user

  def show
    @rooms = Room.all
    @new_room = Room.new
  end
end
