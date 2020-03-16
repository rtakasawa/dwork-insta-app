class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:destroy]

  def create
    favorite = current_user.favorites.create(feed_id: params[:feed_id])
    redirect_to feeds_url,notice: "#{favorite.feed.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to feeds_url,notice: "#{favorite.feed.user.name}さんのブロクをお気に入り登録から解除しました"
  end
  private
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    def favorite_params
      params.require(:favorite).permit(:user_id, :feed_id)
    end
end
