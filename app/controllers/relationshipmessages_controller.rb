class RelationshipmessagesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = User.find(params[:m_request_id])
    current_user.m_send_request(user)
    flash[:success] = 'Request Successful'
    redirect_to matched_users_search_path(current_user)
  end
end
