class Trade1sController < ApplicationController
  def accept_trade1
    current_user.accept_exchange(current_user.trade1)
    flash[:success] = 'Accept Successful'
    redirect_to messages_path(recipient_id: params[:other_user_id])
  end

  def cancel_trade1
    current_user.cancel_exchange(current_user.trade1)
    flash[:success] = 'Cancel Successful'
    redirect_to messages_path(recipient_id: params[:other_user_id])
  end
end
