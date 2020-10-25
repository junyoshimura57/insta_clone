class SorceryCore < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email,            null: false
      # crypted_passwordは暗号化パスワード
      t.string :crypted_password
      # saltは暗号化用データ
      t.string :salt
      #usernameカラムを追加
      t.string :username, null: false
      
      t.timestamps                null: false
    end

    add_index :users, :email, unique: true
  end
end
