require 'v1_interface'

class HomeController < ApplicationController
  def index
    @projects = v1.projects
  end

  def login
    render :login, :layout => 'layouts/anonymous'
  end

  def authenticate
    # do the actual logging in to VersionOne
    # have to store their username and password in a session somewhere...
    #NOTE this is inherently insecure, should probably encrypt it or something, but meh

    #try to connect to version one!
    begin
      v1.test_auth
      session[:username] = params[:username]
      session[:password] = params[:password]
      flash[:notice] = "Woot, you're logged in!"
      if session[:destination]
        path = session[:destination]
        session.delete(:destination)
        redirect_to path
      else
        redirect_to :index
      end
    rescue Exception => e
      flash[:error] = "Unable to log in: #{e.message}"
      redirect_to :login
    end
  end

  def logout
    session.delete(:username)
    session.delete(:password)

    redirect_to :index
  end
end
