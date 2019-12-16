class MainController < ApplicationController

  def mypage
    redirect_to "/main/first" unless user_signed_in?
  end

  def first

  end

  def editor
  end
end
