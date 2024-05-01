class AddPriceToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :price, :integer, null: false
  end
end
