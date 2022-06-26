class ChangeColumnAddNotNullOnTasks < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :title, false
    change_column_null :tasks, :priority, false
    change_column_null :tasks, :deadline, false
  end
end
