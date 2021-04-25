class RelationshipsController < ApplicationController
  def create
    # クエリパラメーターで送られたidを利用して、フォロー対象のユーザーインスタンスを作成
    @user = User.find(params[:followed_id])
    # モデルに定義したインスタンスメソッドを利用してフォロー対象のユーザーをfollowedに追加をする。
    # current_user.follow(@user)
    # フォローをされたのユーザー(@user)の通知設定フラグ(notification_follow)がtureであればメール送信をする。
    UserMailer.with(user_from: current_user, user_to: @user).follow.deliver_later if current_user.follow(@user) && @user.notification_follow?
  end

  def destroy
    # フォロー解除対象のユーザーインスタンスを作成
    @user = Relationship.find(params[:id]).followed
    # モデルに定義したインスタンスメソッドを利用してfollowedから削除。
    current_user.unfollow(@user)
  end
end
