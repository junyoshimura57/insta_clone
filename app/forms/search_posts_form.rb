#  bin/rails g modelコマンドと異なりクラスを最初から自分で記載する必要がある。
class SearchPostsForm
  # バリデーションやフォームヘルパーとの連携ができるようにするため、以下モジュールをインクルード
  include ActiveModel::Model
  # 文字列をモデルの期待しているデータ型に変換するため、以下モジュールをインクルード
  include ActiveModel::Attributes

  #以下に型(DBには保存しない)を定義。
  attribute :post_body, :string
  attribute :comment_body, :string
  attribute :username, :string


  def search
    # searchメソッドについては、TechEssentialsに質問・回答あり。
    scope = Post.distinct
    scope = splited_bodies.map{ |splited_body| scope.body_contain(splited_body) }.inject { |result,scp| result.or(scp) } if post_body.present?
    scope = scope.comment_body_contain(comment_body) if comment_body.present?
    scope = scope.username_contain(username) if username.present?
    # 返り値としてscopeを返す。
    scope
  end

  private

  def splited_bodies
    # ①stripメソッドで先頭と末尾の空白を除去する。
    # ②splitメソッドでスペースとタブが間に入っていた場合に配列に分ける。
    # [:blank:]はPOSIX 文字クラスというもので、スペースとタブを表す正規表現の一種。
    post_body.strip.split( /[[:blank:]]+/)
  end


end
