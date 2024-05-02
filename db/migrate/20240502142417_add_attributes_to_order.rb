class AddAttributesToOrder < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :payment_method, foreign_key: true
    add_column :orders, :adjustment, :integer
    add_column :orders, :adjustment_description, :string
    add_column :orders, :confirmation_date, :date
  end
end
