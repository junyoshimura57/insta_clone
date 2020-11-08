class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      # nullは許容しないオプション追加
      t.text :body, null:false

      t.timestamps
    end
  end
end
