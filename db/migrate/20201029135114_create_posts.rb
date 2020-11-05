class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      # イメージ情報保管用のカラム
      t.string :images, null: false
      t.text :body, null: false
      # references型定義すると外部キー制約がつけられて、自動的にインデックスが作られる。
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
