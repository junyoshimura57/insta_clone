class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      # 「polymorphic: true」とすることで「subject_type(関連先のクラスを入れる)」、「subject_id(関連柵のIDを入れる)」のカラムが作成される。
      t.references :subject, polymorphic: true
      t.references :user, foreign_key: true
      # 何の通知なのかをenumで判別するためのカラム
      t.integer :action_type, null: false
      # 既読かどうかをenumで判別するためのカラム
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end
