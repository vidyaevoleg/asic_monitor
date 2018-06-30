class CreateMachineLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :machine_logs do |t|
      t.string :ip
      t.string :name
      t.text :payload
      t.integer :machine_id, index: true
      t.timestamps
    end
  end
end
