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
end
