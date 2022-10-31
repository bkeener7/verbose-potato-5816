class AddCustomerRefToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :customer, foreign_key: true
  end
end
