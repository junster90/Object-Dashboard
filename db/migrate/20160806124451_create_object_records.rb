class CreateObjectRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :object_records do |t|
      t.integer :object_id
      t.string :object_type
      t.text :object_changes
      t.integer :timestamp, :limit => 8

      t.timestamps null: false
    end
  end
end
