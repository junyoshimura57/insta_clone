# == Schema Information
#
# Table name: activities
#
#  id           :bigint           not null, primary key
#  action_type  :integer          not null
#  read         :boolean          default(FALSE), not null
#  subject_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  subject_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_activities_on_subject_type_and_subject_id  (subject_type,subject_id)
#  index_activities_on_user_id                      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Activity < ApplicationRecord
  # 以下を記載することでactivity.subjectで関連するオブジェクトを取得できる。(自分のカラムを指定するのに凄く違和感があるが、これがpolymorphic)
  belongs_to :subject, polymorphic: true
  belongs_to :user

  scope :recent, ->(count) { order(created_at: :desc).limit(count)}

  # 配列を使用しても定義できるらしいが、今回はハッシュを使用して定義
  enum action_type: { commented_to_own_post: 0, liked_to_own_post:1, followed_me: 2 }
  # readカラムについては、既読　or 未読の2種類のためboolean型でenumを定義
  enum read: { unread: false, read: true }
end
