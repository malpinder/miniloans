class UsersController < ApplicationController
  
  # User signup is done through the Devise UserRegistrations controller - so
  # it's safe to authenticate every action in this controller.
  before_filter :authenticate_user!

  before_action :set_user, except: :index

  def index
    @users = User.all
    authorize! :read, @users
  end

  def show
    authorize! :read, @user
  end

  def edit
    authorize! :update, @user
  end

  def update
    authorize! :update, @user
    if @user.update(user_params)
      sign_in(@user, :bypass => true)
      redirect_to @user, notice: 'Account was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
