class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:request_id])
    current_user.send_request(user)
    flash[:success] = 'Request Successful'
    redirect_to searches_path
  end

  def destroy
    user = User.find(params[:request_id])
    current_user.cancel_request(user)
    flash[:success] = 'Unrequest Successful'
    redirect_to searches_path
  end
end