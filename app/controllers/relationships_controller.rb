class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = User.find(params[:request_id])
    current_user.send_request(user)
    flash[:success] = 'Request Successful'
    redirect_to search_path
  end

  def destroy
    user = User.find(params[:request_id])
    current_user.cancel_request(user)
    flash[:success] = 'Unrequest Successful'
    redirect_to search_path
  end
end
