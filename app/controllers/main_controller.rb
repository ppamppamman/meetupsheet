class MainController < ApplicationController

  def index
    redirect_to "/main/first" unless user_signed_in?
  end

  def first

  end

end
