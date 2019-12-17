class MainController < ApplicationController

  def mypage
    redirect_to "/main/first" unless user_signed_in?
  end

  def first
    redirect_to "/main/mypage" if user_signed_in?
  end

  def editor
  end
end
