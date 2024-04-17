class AddBuffetIdToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_reference :addresses, :buffet, foreign_key: true
  end
end
