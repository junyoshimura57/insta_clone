class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      # なぜreference型で定義をして、外部キー制約を設けないのか調べても分からず...
      # このテーブルにはuserテーブルに存在するidのみの登録で、dependent: :destroyオプションもつけるので外部キー制約をつけた方が良いのかなと思った。
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false

      t.timestamps
    end
    #  referenceでないため、自分でインデックスを貼る
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # フォローの重複を防ぐためにユニーク制約を行う。
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
