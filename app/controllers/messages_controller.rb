class MessagesController < ApplicationController
  def index
    if params[:recipient_id]
      @user = current_user
      @other_user = User.find(params[:recipient_id])
      @trade1 = Trade1.find_or_create_by(user_id: @user.id, trader_id: @other_user.id)
      @trade2 = Trade2.find_or_create_by(user_id: @user.id, trader_id: @other_user.id)
      if trade_canceled?(@trade1)
        exit_trade(@user, @other_user)
        redirect_to root_url
      elsif trade_canceled?(@trade2)
        exit_trade(@user, @other_user)
        redirect_to root_url
      elsif trade_done?(@user, @other_user)
        execute_trade(@user, @other_user)
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
  
  def trade_canceled?(user_trade)
    if user_trade.answer == 'No'
      return true
    else
      return false
    end
  end
  
  def exit_trade(user, other_user)
    user_trade1 = user.trade1
    user_trade1.destroy
    user_trade2 = user.trade2
    user_trade2.destroy
    if other_user.trade1.present?
      other_user_trade1 = other_user.trade1
      other_user_trade2 = other_user.trade2
      other_user_trade1.destroy
      other_user_trade2.destroy
    end
    user_relationshipmessage = Relationshipmessage.find_by(user_id: user.id, m_request_id: other_user.id)
    user_relationshipmessage.destroy
    user.update(message_user_id: nil)
    other_user.update(message_user_id: nil)
  end
  
  def trade_done?(user, other_user)
    if user.trade2.answer == 'Yes' && other_user.trade2.answer == 'Yes'
      return true
    else
      return false
    end
  end
  
  def execute_trade(user, other_user)
    exit_trade(user, other_user)
    other_useruser_relationshipmessage = Relationshipmessage.find_by(user_id: other_user.id, m_request_id: user.id)
    other_useruser_relationshipmessage.destroy
    relationships = []
    Relationship.all.each do |relationship|
      if relationship.user_id = user.id
        relationships << relationship
      elsif relationship.request_id = user.id
        relationships << relationship
      elsif relationship.user_id = other_user.id
        relationships << relationship
      elsif relationship.request_id = other_user.id
        relationships << relationship
      end
    end
    relationships.each do |relationship|
      relationship.destroy
    end
    trade_book(user, other_user)
  end
  
  def trade_book(user, other_user)
    booka = user.book
    bookb = other_user.book
    book1 = Book.new(image: booka.image, title: booka.title, author: booka.author, language: booka.language, page: booka.page, description: booka.description)
    book2 = Book.new(image: bookb.image, title: bookb.title, author: bookb.author, language: bookb.language, page: bookb.page, description: bookb.description)
    Book.find_by(user_id: user.id).update(image: book2.image, title: book2.title, author: book2.author, language: book2.language, page: book2.page, description: book2.description)
    Book.find_by(user_id: other_user.id).update(image: book1.image, title: book1.title, author: book1.author, language: book1.language, page: book1.page, description: book1.description)
  end
end