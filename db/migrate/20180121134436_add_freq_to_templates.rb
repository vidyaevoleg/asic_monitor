class AddFreqToTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :templates, :freq, :integer, default: 400
  end
end
