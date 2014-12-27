class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :weight
      t.boolean :completed
      t.belongs_to :task

      t.timestamps
    end
    add_index :records, :task_id
  end
end
