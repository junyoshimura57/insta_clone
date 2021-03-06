class ActivitiesController < ApplicationController
  before_action :require_login, only: %i[read]

  def read
    # 自分の投稿インスタンスを取得するのと同様にcurrent_userからの関連を使う
    activity = current_user.activities.find(params[:id])
    # enumの更新メソッドと確認メソッドを使用して既読管理を行う（便利！！）
    activity.read! if activity.unread?
    # 通知の種類によってリダイレクト先を分ける。(モデルにロジックは定義)
    redirect_to activity.redirect_path
  end
end
