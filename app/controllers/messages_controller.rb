class MessagesController < ApplicationController
  def index
    if params[:recipient_id]
      @user = current_user
      @other_user = User.find(params[:recipient_id])
      @trade1 = Trade1.find_or_create_by(user_id: @user.id, trader_id: @other_user.id)
      @trade2 = Trade2.find_or_create_by(user_id: @user.id, trader_id: @other_user.id)
      if trade1_canceled?(@user, @other_user)
        exit_trade1(@user, @other_user)
        redirect_to root_url
      else
        @user.go_to_message(@other_user)
        @messages = Message.where(user_id: current_user.id, recipient_id: params[:recipient_id])
        .or(Message.where(user_id: params[:recipient_id], recipient_id: current_user.id)).order(created_at: :asc)
        @message = current_user.messages.build
      end
    end
  end

  def create
    other_user = User.find(params[:recipient_id])
    content = params[:message][:content]
    @message = current_user.send_message(other_user, content)
    if @message.save
      flash[:success] = 'Message Sent'
      redirect_to messages_path(recipient_id: other_user.id)
    else
      flash[:danger] = 'Message Failed'
      redirect_to messages_path(recipient_id: other_user.id)
    end
  end
  
  private
  
  def trade1_canceled?(user, other_user)
    if user.trade1.answer == 'No'
      return true
    elsif other_user.trade1.present?
      if other_user.trade1.answer == 'No'
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  def exit_trade1(user, other_user)
    user_trade1 = user.trade1
    user_trade1.destroy
    if other_user.trade1.present?
      other_user_trade1 = other_user.trade1
      other_user_trade1.destroy
    end
    user_relationshipmessage = Relationshipmessage.find_by(user_id: user.id, m_request_id: other_user.id)
    user_relationshipmessage.destroy
    user.update(message_user_id: nil)
    other_user.update(message_user_id: nil)
  end
end