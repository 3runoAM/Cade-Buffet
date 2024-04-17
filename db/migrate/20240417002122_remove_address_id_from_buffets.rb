class RemoveAddressIdFromBuffets < ActiveRecord::Migration[7.1]
  def change
    remove_reference :buffets, :address_id
  end
end
