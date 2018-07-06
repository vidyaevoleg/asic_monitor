class AddRefererToLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :machine_logs, :referer, :string
  end
end
