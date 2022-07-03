class AddIndexsToTables < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :id
    add_index :tasks, :id
  end
end
