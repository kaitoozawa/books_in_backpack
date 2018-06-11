class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Signup Successful'
      redirect_to root_url
    else
      flash.now[:danger] = 'Signup Failed'
      render :new
    end
  end
  
  def update_mylocation
    current_user.update(mylocation_id: params[:mylocation_id])
  end
  
  # def update_message_user_id
  #   current_user.update(message_user_id: params[:message_user_id])
  #   redirect_to search_path
  # end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end