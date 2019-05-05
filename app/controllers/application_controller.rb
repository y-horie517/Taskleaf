class ApplicationController < ActionController::Base
    helper_method :current_user
    before_action :ligin_required

    private
    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_
        redirect_to login_path unless current_user
    end
end
