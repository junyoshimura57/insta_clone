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

  # 【特定のユーザーがフォローをしているユーザーとの関係】
  # ■relationshipsテーブ(中間テーブル)との関連を定義
  # ①名前被りを防ぐため、active_をつけて、class_nameオプションでモデル指定。
  # ②「user_id」が外部キーではないため、foreign_keyオプションで外部キーを指定。
  # ③ユーザーを削除した時に中間テーブルの該当項目も削除したいため、dependent: :destroyオプションを指定。
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # ■followedテーブル(usersテーブル)との関連を定義(active_relationships経緯)
  # 中間テーブルを介してfollowedモデルのUser(フォローされた側)を集めることを「following」と定義する。(source: :userとやりたくなるが、user_idと内部結合使用としてしまうためNG)
  has_many :following, through: :active_relationships, source: :followed

  # 【特定のユーザーがフォローされるユーザーとの関係】
  # ■relationshipsテーブル(中間テーブル)との関連を定義
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  # ■followerテーブル(usersテーブル)との関連を定義(passive_relationships経緯)
  has_many :followers, through: :passive_relationships, source: :follower

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

  # ①self.followingでcurrent_userがフォローしたユーザーを取得。
  # ②引数のユーザーを①に追加
  def follow(other_user)
    following << other_user
  end

  # ①self.followingでcurrent_userがフォローしたユーザーを取得。
  # ②destroyメソッドをメソッドチェーンして、引数のユーザーを削除。
  def unfollow(other_user)
    following.destroy(other_user)
  end

  # ①self.followingでcurrent_userがフォローしたユーザーを取得。
  # ②include?メソッドをメソッドチェーンして、引数のユーザーが含まれているか確認。(フォローしているか確認できる)
  def following?(other_user)
    following.include?(other_user)
  end

  # ①「self.following_ids << self.id」でcurrent_userがフォローしているユーザーidにcurrent_userのユーザーidを追加する。
  # ②postテーブルで上記①のユーザーidの投稿をActiveRecord::Relationで返す。(自分と投稿とフォローしているユーザーの投稿を取得できる)
  def feed
    Post.where(user_id: following_ids << id)
  end

  # scopeでrecentメソッド()を定義する。
  # クラスメソッドと異なり常にActiveRecord::Relationオブジェクトを返すためメソッドチェーンを使える。(nilの場合は、allメソッドとなる)
  scope :recent, ->(count) { order(created_at: :desc).limit(count) }
end
