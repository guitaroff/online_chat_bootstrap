class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::NotNullViolation, with: :render_invalid_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def set_current_user
    @current_user = current_user
    redirect_to new_user_session_path unless @current_user
  end

  def render_invalid_error
    flash[:error] = 'Не заполнены необходимые поля'
    redirect_to root_path
  end

  def render_not_found
    flash[:error] = 'Запись не найдена'
    redirect_to root_path
  end
end
