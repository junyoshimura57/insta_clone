class LikesController < ApplicationController
  # ログインユーザーのみいいねできるようにフィルタを設定
  before_action :require_login, only: %i[create destroy]
  def create
    @post = Post.find(params[:post_id])
    # 今まで以下のようにcreateメソッドを使用する方法しか知らなかったので違和感がある。(以下でも動いたので、間違いではなさそう)
    # @like =  current_user.likes.create(post_id: @post.id)
    # current_user.like(@post)
    # withメソッドでメイラーからparamsで取得できるようにする。
    # deliver_laterメソッドを使って非同期でメール送信を行う。(Active Jobを裏側で使っているらしい...)
    UserMailer.with(user_form: current_user, user_to: @post.user, post: @post).like_post.deliver_later if current_user.like(@post)
  end

  def destroy
    # likesテーブルからid(likesテーブルの主キー)を検索して、アソシエーションを使ってpostオブジェクトを取得
    @post = Like.find(params[:id]).post
    current_user.unlike(@post)
    # 以下の方が個人的には馴染みがある。(「@post = @like.post」の部分がイマイチかも)
    # @like = Like.find(params[:id])
    # @like.destroy
    # @post = @like.post
  end
end
