class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to feeds_path,notice: "ユーザー情報を更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :my_image, :my_image_cache)
    end
end