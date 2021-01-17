class AddAvatarToUsers < ActiveRecord::Migration[5.2]
  def change
    # add_columnの場合は、up・downで記載する必要はない。
    add_column :users, :avatar, :string
  end
end
