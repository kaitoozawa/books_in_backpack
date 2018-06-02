class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
  end
  
  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      flash[:success] = 'Profile Registeration Successful'
      redirect_to root_url
    else
      flash.now[:danger] = 'Profile Registration Failed'
      render :new
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      flash[:success] = 'Profile Update Successful'
      redirect_to profile
    else
      flash.now[:danger] = 'Profile Update Failed'
      render :edit
    end
  end
  
  private
  
  def profile_params
    params.require(:profile).permit(:image, :name, :nationality, :gender, :age, :description)
  end
end