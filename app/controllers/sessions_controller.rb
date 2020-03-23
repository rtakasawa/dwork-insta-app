class SessionsController < ApplicationController
  def new
  end

  #ログイン時のアクション
  def create
    #paramsメソッドでブラウザから送信されたemailを取得し、
    # find_byメソッドで送信されたemailとUserモデルのDBの中から同じユーザーの情報を検索する。
    # 同じユーザーの情報があれば情報を取得し、変数userに代入する。
    # find_byメソッドは、検索し最初に該当した情報（レコード）１件を返す。
    # そのため、ユニーク制限されているカラムで情報を検索する際に使用する。
    # emailやpasswordかな？
    # 情報がない場合が、nilを返す。
    user = User.find_by(email: params[:session][:email].downcase)
    # &&の前のuserは変数userの情報が入る。上で情報がなければnilになってる。
    # &&以降のコードについて
    # has_secure_passwordメソッドを使うと、authenticateメソッドが使える
    # ようになる (引数の文字列がパスワードと一致するとUserオブジェクトを、
    # 間違っているとfalse返すメソッド)。
    # 上でログインしたユーザーの情報をuserに代入している。
    # ログインした際にユーザーが入力したパスワードと変数userの情報が
    # イコールならユーザーのパスワードを返す。
    # イコールじゃなければfalseを返す。
    # ＜結論＞メールとパスワードで検証しているというコード。
    if user && user.authenticate(params[:session][:password])
      # ログイン画面で入力された情報がUserモデルのDB内の情報と合致した場合は
      # user.idをsessionのuser_idカラムに保存する。
      session[:user_id] = user.id
      redirect_to feeds_path
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end


