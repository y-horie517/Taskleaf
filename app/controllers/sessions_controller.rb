class SessionsController < ApplicationController
  def new
  end

  def create
    # 入力されたemailからユーザを検索
    user = User.find_by(email: session_params[:email])
    #has_secure_password追加時に自動で追加されたメソッド
    #引数で受け取ったパスワードをハッシュ化して、結果をUserオブジェクト内部のdigestと比較
    #一致したら、userオブジェクト自身を返す。一致しなければ、falseを返す。
    # メールアドレスが見つからない場合、user変数がnilになるため、ぼっち演算子使用
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.user_id
      redirect_to root_path, notice: 'ログインしました。'
    else
      render: new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end
  
  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
