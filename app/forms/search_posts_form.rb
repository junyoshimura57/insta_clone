#  bin/rails g modelコマンドと異なりクラスを最初から自分で記載する必要がある。
class SearchPostsFrom
  # バリデーションやフォームヘルパーとの連携ができるようにするため、以下モジュールをインクルード
  include ActiveModel::Model
  # 文字列をモデルの期待しているデータ型に変換するため、以下モジュールをインクルード
  include ActiveModel::Attributes

  #以下に型(DBには保存しない)を定義。
  attribute :body, :string
  attribute :comment_body, :string
  attribute :username, :string


  def search

  end


end
