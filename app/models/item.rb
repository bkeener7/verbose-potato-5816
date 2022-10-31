class Item < ApplicationRecord
  belongs_to :supermarket
  has_many :customer_baskets
  has_many :customers, through: :customer_baskets

  def customer_count
    customers.length
  end
end
