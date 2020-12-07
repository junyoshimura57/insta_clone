# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  salt             :string(255)
#  username         :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  authenticates_with_sorcery!
  # 以下バリデーションを追加(回答も見ながら写経)

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  # 「if: ->」と書き方は見慣れないが、->の右側がtureであればバリデーションが実行される？？
  # new_record?(新しいレコード)もしくはchanges[:crypted_password](パスワード更新時)にバリデーションが実行される？？
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # 関連を定義。dependentオプションでuserが削除されたら、関連するpostも削除とする。
  has_many :posts, dependent: :destroy

  # 後から関連モデルを作成しても既存のモデルには関連の定義は自動では記載されないため注意する。
  has_many :comments, dependent: :destroy

  # postsモデルと同様に関連を定義する。
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  # 投稿が自身のものかを判別するためのメソッドを定義
  def own?(object)
    id == object.user_id
  end

  # ①self.like_postsでcurrent_userがlikeをしたpostをlikesテーブル経由で取得。
  # ②引数のpost(いいねをしたい投稿)を①に追加をする。
  def like(post)
    like_posts << post
  end

  # ①self.like_postsでcurrent_userがlikeをしたpostをlikesテーブル経由で取得。
  # ②引数のpost(いいねを解除したい投稿)を①から削除をする。
  def unlike(post)
    like_posts.destroy(post)
  end

  # ①self.like_postsでcurrent_userがlikeをしたpostをlikesテーブル経由で取得。
  # ②include?メソッドで引数のpostオブジェクトが①にあるかを確認。
  # ③②の結果によりtrue,falseを返す。
  def like?(post)
    like_posts.include?(post)
  end
end
