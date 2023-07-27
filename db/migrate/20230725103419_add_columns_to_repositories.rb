class AddColumnsToRepositories < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :watchers, :integer
    add_column :repositories, :default_branch, :string
    add_column :repositories, :clone_url, :string
    add_column :repositories, :repo_count, :integer
  end
end
