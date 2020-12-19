# == Schema Information
#
# Table name: relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
class Relationship < ApplicationRecord
  # belongs_to :userとしたいとこだが、今回は1つのuserテーブルに対して「Follower_id」、「Followed_id」という2つの関連付けをさせるため以下のように記載する。  
  # class_name:の箇所は文字列になることに地味に注意
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  # モデル側で以下のバリデーションをつける
  validates :follower_id, presence true
  validates :followed_id, presence true
  validates :follower_id, :uniqueness: {scope: :followed_id}
end
