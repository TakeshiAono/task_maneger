class AddChangeDefaultStatusToTask < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tasks, :status, from: false, to: "not_yet"
  end
end
