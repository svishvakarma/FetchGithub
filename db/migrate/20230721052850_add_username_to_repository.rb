class AddUsernameToRepository < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :username, :string
  end
end
