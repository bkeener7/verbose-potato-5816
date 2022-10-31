class Item < ApplicationRecord
  belongs_to :supermarket
  belongs_to :customer
end
