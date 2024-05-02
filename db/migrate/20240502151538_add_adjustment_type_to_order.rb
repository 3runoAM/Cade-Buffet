class AddAdjustmentTypeToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :adjustment_type, :integer, default: 0
  end
end
