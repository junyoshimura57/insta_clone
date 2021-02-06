# MypageのBaseControllerを継承させる。
class Mypage::ActivitiesController < Mypage::BaseController
  before_action :require_login, only: %i[index]

  def index
    # 最新10件の通知をkaminariを使って表示する
    @activities = current_user.activities.order(created_at: :desc).page(params[:page]).per(10)
  end
end
