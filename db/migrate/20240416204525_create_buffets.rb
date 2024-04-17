class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :brand_name, null: false
      t.string :company_name, null: false
      t.string :crn, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.string :description
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
