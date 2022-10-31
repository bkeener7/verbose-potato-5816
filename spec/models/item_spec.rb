require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many(:customers).through(:customer_baskets) }
  end

  it 'can count how many customers have item in basket' do
    supermarket1 = Supermarket.create!(name: 'Costco', location: 'Timnath')
    supermarket2 = Supermarket.create!(name: 'Whole Foods', location: 'Fort Collins')
    customer1 = Customer.create!(name: 'Bruce Wayne')
    customer2 = Customer.create!(name: 'Barack Obama')
    customer3 = Customer.create!(name: 'Diogenes')
    item1 = Item.create!(name: 'Fresca', price: 1, supermarket_id: supermarket1.id)
    item2 = Item.create!(name: 'Topochico', price: 2, supermarket_id: supermarket1.id)
    item3 = Item.create!(name: 'LaCroix', price: 5, supermarket_id: supermarket2.id)
    item4 = Item.create!(name: 'Spindrift', price: 3, supermarket_id: supermarket2.id)
    CustomerBasket.create!(item_id: item1.id, customer_id: customer1.id)
    CustomerBasket.create!(item_id: item1.id, customer_id: customer3.id)
    CustomerBasket.create!(item_id: item2.id, customer_id: customer1.id)
    CustomerBasket.create!(item_id: item3.id, customer_id: customer1.id)
    CustomerBasket.create!(item_id: item3.id, customer_id: customer2.id)
    CustomerBasket.create!(item_id: item3.id, customer_id: customer3.id)

    expect(item1.customer_count).to eq(2)
    expect(item2.customer_count).to eq(1)
    expect(item3.customer_count).to eq(3)
    expect(item4.customer_count).to eq(0)
  end
end
