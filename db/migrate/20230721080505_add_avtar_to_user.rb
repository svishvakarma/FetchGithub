class AddAvtarToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_avatar_url, :string
  end
end
