class SearchesController < ApplicationController
  def index
    @mylocation = Mylocation.find_by(id: current_user.mylocation_id)
    @users = @mylocation.users
    @books = []
    @users.each do |user|
      if user.book.present?
        @books << user.book
      end
    end
  end
  
  def request_users
    @request_users = []
    current_user.requestings.each do |user|
      unless current_user.match_exist?(user)
        @request_users << user
      end
    end
  end
  
  def requested_users
    @requested_users = []
    current_user.requesteds.each do |user|
      unless current_user.match_exist?(user)
        @requested_users << user
      end
    end
  end
  
  def matched_users
    request_users = current_user.requestings
    @match_users = []
    request_users.each do |user|
      if current_user.match_exist?(user)
        @match_users << user
      end
    end
  end
end