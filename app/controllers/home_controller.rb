class HomeController < ApplicationController
  skip_before_action :check_auth_user

  def show
  end
end
