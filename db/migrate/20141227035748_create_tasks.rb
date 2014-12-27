class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :reminder_type
      t.string :frequency
      t.time :reminder_time
      t.text :message
      t.belongs_to :user

      t.timestamps
    end
    add_index :tasks, :user_id
  end
end
