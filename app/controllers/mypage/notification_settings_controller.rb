class Mypage::NotificationSettingsController < Mypage::BaseController
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(notification_params)
      # 　更新が成功した場合には、フレッシュメッセージを渡して、通知編集画面にリダイレクト。
      redirect_to edit_mypage_notification_setting_path, success: '通知設定を更新しました'
    else
      flash.now['danger'] = '通知設定の更新に失敗しました'
      render :edit
    end
  end

  private

  def notification_params
    params.require(:user).permit(:notification_like, :notification_comment, :notification_follow)
  end
end
