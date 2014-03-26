class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :user_preferences

  def user_preferences
   user = current_user.presence || User.new
      {
          theme: user.settings(:snippets).theme,
          line_numbers: user.settings(:snippets).line_numbers,
          expand: user.settings(:snippets).expand

      }
  end

end
