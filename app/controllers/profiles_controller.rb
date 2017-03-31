class ProfilesController < ApplicationController

  # GET to /users/:user_id/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end

  # POST to /users/:user_id/profile
  def create
    # Ensure that we have the user who is filling out this form
    @user = User.find( params[:user_id] )
    # Create profile linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end

  # GET to /users/:user_id/profile/
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end

  # PATCH to /users/:user_id/profile/
  def update
    @user = User.find( params[:user_id] )
    @profile = @user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :edit
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :avatar, :phone_number, :job_title, :contact_email, :description)
  end
end
