class AddNotificationSignToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column  :users, :notification_like, :boolean, default: true
    add_column  :users, :notification_comment, :boolean, default: true
    add_column  :users, :notification_follow, :boolean, default: true
  end
end
