class UserSessionsController < ApplicationController
  def new; end

  def create
    # sorceryを使っている場合は、loginメソッドでUserモデルから検索できる。ただなぜストロングパラメーターは不要？？
    @user = login(params[:email], params[:password])

    if @user
      # redirect_back_or_toで他の認証必要なページのURLを保存している場合は、認証後にそのURLにリダイレクトできる。
      redirect_back_or_to root_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました'
  end
end
