class AddIsCurrentToWarehouse < ActiveRecord::Migration[5.0]
  def change
    add_column :warehouses, :is_current, :boolean
  end
end
