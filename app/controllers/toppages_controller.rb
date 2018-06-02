class ToppagesController < ApplicationController
  def index
    if logged_in?
      @book = current_user.book
    end
  end
end