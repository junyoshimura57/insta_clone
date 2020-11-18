class PostsController < ApplicationController
  # 「require_login」はsorceryにより使用可能。
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    # 「複数のUserが投稿したPostを全件取得」かつ「誰が投稿したかアソシエーションを使用して表示」するとN+1問題(usersテーブルに1回+postsテーブルにN回アクセスのSQLが発生する問題)が発生する。
    # そのためincludesメソッドを使用して、「postsの全内容取得」と「関連するuserの全件取得」をしておく。(preloadを使用してもいいはず！)
    # params[:page]で表示するページ番号を渡しており、pageメソッドで渡されたページ番号の範囲のデータを取得している。  
    @posts = Post.all.includes(:user).page(params[:page]).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    # current_userに関連させてpostインスタンスを作成する。
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def edit
    # current_user.postsとすることで「user_idがcurrent_userの同一id（自分の投稿）」のpostからfindできる。
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, success: '投稿を更新しました'
    else
      flash.now[:danger] = '投稿の更新に失敗しました'
      render :edit
    end
  end

  def show
    # 他のユーザーの投稿の詳細ページも見たいので、current_user.postsとはしない。
    @post = Post.find(params[:id])
    # postの詳細画面にコメントを非同期で表示させるために以下を記載。
    # どのユーザーのコメントかの情報も表示するのにN+1問題を避けるためincludesでuser情報も取得。
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    # コメントにとってpostのshowアクションが新規登録画面となるのでコメントインスタンスを作成。
    @comment = Comment.new
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    # 削除が失敗したら例外をだす。
    @post.destroy!
    redirect_to posts_path, success: '投稿を削除しました'
  end

  private

  # 画像が単数の場合は:imageで良いが、複数の場合はimages: []とする。
  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
