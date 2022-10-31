class CreateCustomerBasket < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_baskets do |t|
      t.references :item, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
