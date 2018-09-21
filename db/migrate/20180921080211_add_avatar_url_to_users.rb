class AddAvatarUrlToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar_url, :string, :default => "https://www.w3schools.com/w3images/avatar2.png"
  end
end
