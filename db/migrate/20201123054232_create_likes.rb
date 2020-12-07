class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
      # 同じユーザーが同じ投稿にいいねをするのを避けるため、一意制約をする。(全てのデータを検索する必要があるためインデックスを貼る必要がある)
      t.index [:user_id, :post_id], unique: true
    end
  end
end
