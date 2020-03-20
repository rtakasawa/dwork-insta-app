class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :authenticate_user, only: [:show, :edit, :update]
  before_action :ensure_user_page, only: [:show, :edit, :update]

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

  private
    def set_user
      @user = User.find(params[:id])
      if current_user == nil
        flash[:notice] = "権限がありません"
        redirect_to new_session_url
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :my_image, :my_image_cache)
    end

  def ensure_user_page
    @user = User.find_by(id:params[:id])
    if @user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to new_session_url
    end
  end
end