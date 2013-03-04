class HomeController < ApplicationController
  def index

  end

  def login
      render :login, :layout => 'layouts/anonymous'
  end
end
