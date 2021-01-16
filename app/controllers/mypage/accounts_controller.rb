# BaseControllerを継承する。
class Mypage::AccountController < Mypage::BaseController
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(account_params)
      #　更新が成功した場合には、フラッシュメッセージを渡して、編集画面にレンダリング
      redirect_to edit_mypage_account_path, success: 'プロフィールを更新しました'
    else
      # flash.nowで同じリクエスト内でフラッシュメッセージを表示
      flash.now['danger'] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end

  private

  def account_params
    params.require(:user).permit(:email, :avatar, :avatar_cache)
  end
end
