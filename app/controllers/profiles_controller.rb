class ProfilesController < ApplicationController
  before_action :set_profile

  def show
    #render 'profile/show' by default
  end

  # GET '/profile/:id/edit'
  def edit # url will be something like /profile/3/edit, goto devise registration form
    redirect_to edit_user_registration_path
  end

  private

    def set_profile
      #devise gives us current_user
      @current_user = current_user
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :address, :phone, :about, :email, :password)
    end
end
