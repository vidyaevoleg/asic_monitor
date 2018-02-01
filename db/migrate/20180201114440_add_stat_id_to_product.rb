class AddStatIdToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :machines, :stat_id, :integer, index: true 
  end
end
