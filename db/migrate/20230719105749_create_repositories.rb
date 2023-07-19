class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories do |t|
      t.string :title
      t.string :language
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
