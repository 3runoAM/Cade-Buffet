class RemoveAddressIdFromBuffet < ActiveRecord::Migration[7.1]
  def change
    remove_column :buffets, :address_id, :integer
  end
end
