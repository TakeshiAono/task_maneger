class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :priority
      t.string :name
      t.date :deadline

      t.timestamps
    end
  end
end
