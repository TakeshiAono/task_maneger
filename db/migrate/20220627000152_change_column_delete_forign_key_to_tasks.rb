class ChangeColumnDeleteForignKeyToTasks < ActiveRecord::Migration[6.0]
  def change
    # remove_forign_key :tasks, :users
    # remove_index :tasks, :user_id
    remove_column :tasks, :user_id
  end
end
