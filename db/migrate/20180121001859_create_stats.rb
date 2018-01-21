class CreateStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.integer :blocks
      t.decimal :hashrate
      t.boolean :valid
      t.boolean :active, default: false
      t.text :temparatures
      t.references :machine, index: true
      t.timestamps
    end
  end
end
