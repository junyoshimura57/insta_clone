class CommentsController < ApplicationController
  before_action :require_login, only: %i[create edit update destroy]

  def create
    # ログイン中のユーザーと関連をさせて、コメントのインスタンス作成する。(関連を使用する時は慣習的にnewでなく、buildを使う。)
    # user_idはcurrent_userを使って、post_idはURLからparams経由で登録をする。
    @comment = current_user.comments.build(comment_params)
    # @comment.save
    UserMailer.with(user_from: current_user, user_to: @comment.post.user, comment: @comment).comment_post.deliver_later if @comment.save
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update(comment_update_params)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    # mergeメソッドを使用することで、URLに含まれるpost_idをActionController::Parametersインスタンスを生成できる。
    # コンソールで右記を確認。<ActionController::Parameters {"body"=>"テスト", "post_id"=>"44"} permitted: true>
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end

  def comment_update_params
    # post_idはすでに保存されているため、merge不要。(外部キーはpermitにカラム記載不要！)
    params.require(:comment).permit(:body)
  end
end
