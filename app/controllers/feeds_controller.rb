class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def show

    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    return if @feed.valid?
    flash[:notice] = "いずれかを入力してください"
    render :new
  end

  def edit
  end

  def create
    @feed = current_user.feeds.build(feed_params)
    respond_to do |format|
      if @feed.save
        FeedMailer.feed_mail(@feed).deliver
        format.html { redirect_to @feed, notice: '投稿が完了しました！' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: '編集が完了しました！' }
        format.json { render :show, status: :ok, location: @feed }
      else
        flash[:notice] = "いずれかを入力してください"
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: '削除が完了しました！' }
      format.json { head :no_content }
    end
  end

  private
  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:image, :image_cache, :content)
  end

  #投稿内容の編集や削除を投稿者のみに制限する
  def ensure_correct_user
    # paramsメソッドで、飛んできたfeed.idを取得し、Feedモデルのデータベースから
    # 該当のレコードの情報を取得し、変数@feedに代入する。
    @feed = Feed.find_by(id:params[:id])
    #投稿者のuser_idとログインしているuser.idを検証し、異なる場合はログイン画面に飛ばす。
    if @feed.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to new_session_url
    end
  end

end