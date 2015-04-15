class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update]
  before_filter :validate_authorization_for_user, only: [:edit, :update]

  # GET /users/1
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    # byebug
    Rails.logger.info user_params.inspect
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to @user, notice: t('messages.user_updated')
    else
      render action: :edit
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def validate_authorization_for_user
    redirect_to root_path unless @user == current_user
  end

  def user_params
    params.require(:user).permit(
      :name, :about
    )
  end
end
