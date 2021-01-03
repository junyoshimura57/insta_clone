class ApplicationController < ActionController::Base
  # どのページに遷移した時でもset_search_posts_formを動かすようにする。
  before_action :set_search_posts_form
  # デフォルトのフラッシュメッセージは、noticeとalertのキーしか使えないため以下を追加。
  add_flash_types :success, :info, :warning, :danger

  private

  # どのページからも検索できるようにするためにApplicationControllerにインスタンスを定義
  def set_search_posts_form
    @search_form = SearchPostsForm.new(search_post_params)
  end

  def search_post_params
    # 検索値がない場合は、エラーを出さないようにするためにfetchメソッドを使う
    params.fetch(:q, {}).permit(:post_body, :comment_body, :username)
  end
end
