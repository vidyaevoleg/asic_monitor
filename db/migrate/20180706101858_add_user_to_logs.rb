class AddUserToLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :machine_logs, :user, :string
  end
end
