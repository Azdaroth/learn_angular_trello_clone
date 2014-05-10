class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.integer :board_id, null: false
      t.integer :priority, null: false, default: 0

      t.timestamps
    end
    add_index :lists, :board_id
  end
end
