# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  #　コメントを削除すると関連アクティティも削除する。
  #　commnetsテーブルとactivitiesテーブルの関係は、1対多なのでhas_manyで関連付け。
  has_many :activity, as: :subject, dependent: :destroy

  # nullは不可および文字数を1000文字までに制限するバリデーションを追加’
  validates :body, presence: true, length: { maximum: 1000 }

  # after_create_commitは、after_commitのエイリアス
  # インスタンスがcreateされた後に以下を関数をコールバックする。
  after_create_commit :create_activities

  private

  def create_activities
    # インスタンスメソッド内のselfなので、commentインスタンスが入る。
    # action_typeにはenumで定義をした項目を入れる。
    Activity.create(subject: self, user: post.user, action_type: :commented_to_own_post)
  end
end
