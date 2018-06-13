class Trade2sController < ApplicationController
  def accept_trade2
    current_user.trade2_accept_exchange(current_user.trade2)
    flash[:success] = 'Accept Successful'
    redirect_to messages_path(recipient_id: params[:other_user_id])
  end

  def cancel_trade2
    current_user.trade2_cancel_exchange(current_user.trade2)
    flash[:success] = 'Cancel Successful'
    redirect_to messages_path(recipient_id: params[:other_user_id])
  end
end
