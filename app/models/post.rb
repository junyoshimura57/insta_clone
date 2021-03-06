# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  images     :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  # reference型で定義すると以下の関連も自動で定義される。
  belongs_to :user
  # 「アップロード画像用のカラム」と「アップローダークラス」を紐づける為に以下を記載。(複数の画像を扱うために)mount_uploader「s」)
  mount_uploaders :images, PostImageUploader
  # imagesはstring型で定義をしたため、JSON型で配列を保存するために定義。(mysqlを使用しているので、そもそもJSON型で定義しても良かったかも？？)
  serialize :images, JSON
  # バリデーションを追加
  validates :images, presence: true
  validates :body, presence: true, length: { maximum: 1000 }

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # likesテーブルを通してusersテーブルの情報も取得できるようにするために以下を定義
  # アソシエーション名をテーブル名と変更しているため、sourceモデル名(単数形！)を記載する。
  has_many :like_users, through: :likes, source: :user

  # 検索クエリのスコープを以下に定義
  scope :body_contain, ->(word) { where('body LIKE ?', "%#{word}%") }
  # commentsテーブルのcomment.bodyカラムを検索したいため、内部結合をする。またbodyカラムは名前が被るため、「comments.」としてテーブル特定をする。
  scope :comment_body_contain, ->(word) { joins(:comments).where('comments.body LIKE ?', "%#{word}%") }
  scope :username_contain, ->(word) { joins(:user).where('username LIKE ?', "%#{word}%") }
end
