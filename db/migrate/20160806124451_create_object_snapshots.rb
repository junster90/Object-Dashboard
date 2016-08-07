class CreateObjectSnapshots < ActiveRecord::Migration[5.0]
  def change
    create_table :object_snapshots do |t|
      t.integer :object_id
      t.string :object_type
      t.text :object_changes
      t.datetime :timestamp

      t.timestamps, null: false
    end
  end
end