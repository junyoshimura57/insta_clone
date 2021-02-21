class UserMailer < ApplicationMailer
  # 3パターンのメールアクションを定義する。
  def like_post
    # LikesControllerのcreateアクションからwithメソッドの引数で渡された値をparamsで取得できる。(パRailsに記載あり)
    # さらにメールのビューファイルで使用するためにインスタンス変数に渡す。
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @post = params[:post]
    # mailメソッドの引数に宛先と題名を設定する。
    mail(to: @user_to.email, subject: "#{@user_from.username}があなたの投稿にいいねをしました")
  end

  def comment_post
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @comment = params[:comment]
    mail(to: @user_to.email, subject: "#{@user_from.username}があなたの投稿にコメントをしました")
  end

  def follow
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    mail(to: @user_to.email, subject: "#{@user_from.username}があなたをフォローしました")
  end

end
