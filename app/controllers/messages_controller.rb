class MessagesController < ApplicationController
  def index
    @user = current_user
    @other_user = User.find(params[:recipient_id])
    @user.go_to_message(@other_user)
    @messages = Message.where(user_id: current_user.id, recipient_id: params[:recipient_id])
    .or(Message.where(user_id: params[:recipient_id], recipient_id: current_user.id)).order(created_at: :asc)
    @message = current_user.messages.build
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
end