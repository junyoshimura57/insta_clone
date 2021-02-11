# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_post_id              (post_id)
#  index_likes_on_user_id              (user_id)
#  index_likes_on_user_id_and_post_id  (user_id,post_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :activity, as: :subject, dependent: :destroy

  # scopeを付けないと「1ユーザー」が「1いいね」しかできなくなってしまうので、scopeで「投稿単位」の一意制約とする。(複数項目をscopeに設定することもできる)
  validates :user_id, uniqueness: { scope: :post_id }

  after_create_commit :create_activities

  private

  def create_activities
    Activity.create(subject: self, user: post.user, action_type: :liked_to_own_post)
  end
end
