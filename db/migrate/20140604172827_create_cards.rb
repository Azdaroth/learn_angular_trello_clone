class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :list_id, null: false
      t.integer :priority, null: false, default: 1
      t.string :name, null: false, default: ""
      t.text :description

      t.timestamps
    end
    add_index :cards, :list_id
  end
end
