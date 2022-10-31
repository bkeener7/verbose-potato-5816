class Customer < ApplicationRecord
  has_many :customer_baskets
  has_many :items, through: :customer_baskets
end
