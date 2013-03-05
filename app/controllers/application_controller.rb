require 'v1_interface'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_login

  def v1
    V1::V1Interface.new(session[:username], session[:password])
  end


  private

  def require_login
    puts "request path is: #{request.path}"
    unless request.path == "/login"
      unless session[:username] and session[:password]
        flash[:error] = "Have to log in first, brosef"
        #save where they wanted to go
        session[:destination] = request.path
        redirect_to login_path
      end
    end
  end

end
