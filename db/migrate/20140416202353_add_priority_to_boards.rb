class AddPriorityToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :priority, :integer, null: false, default: 1
    add_index :boards, :priority
  end
end
