require 'rails_helper'

RSpec.describe 'items' do
  before :each do
    @supermarket1 = Supermarket.create!(name: 'Costco', location: 'Timnath')
    @supermarket2 = Supermarket.create!(name: 'Whole Foods', location: 'Fort Collins')
    @customer1 = Customer.create!(name: 'Bruce Wayne')
    @customer2 = Customer.create!(name: 'Barack Obama')
    @customer3 = Customer.create!(name: 'Diogenes')
    @item1 = Item.create!(name: 'Fresca', price: 1, supermarket_id: @supermarket1.id)
    @item2 = Item.create!(name: 'Topochico', price: 2, supermarket_id: @supermarket1.id)
    @item3 = Item.create!(name: 'LaCroix', price: 5, supermarket_id: @supermarket2.id)
    CustomerBasket.create!(item_id: @item1.id, customer_id: @customer1.id)
    CustomerBasket.create!(item_id: @item1.id, customer_id: @customer3.id)
    CustomerBasket.create!(item_id: @item2.id, customer_id: @customer1.id)
    CustomerBasket.create!(item_id: @item3.id, customer_id: @customer1.id)
    CustomerBasket.create!(item_id: @item3.id, customer_id: @customer2.id)
    CustomerBasket.create!(item_id: @item3.id, customer_id: @customer3.id)
  end

  describe 'items index page' do
    it 'sees a list of all items' do
      visit '/items'
      expect(current_path).to eq('/items')

      within '#all_items' do
        expect(page).to have_content(1)
        expect(page).to have_content(2)
        expect(page).to have_content(5)
        expect(page).to have_content('Costco')
        expect(page).to have_content('Whole Foods')
        expect(page).to have_content('Fresca')
        expect(page).to have_content('Topochico')
        expect(page).to have_content('LaCroix')
      end
    end

    it 'sees a count of all customers who have bought this item' do
      visit '/items'

      within '#all_items' do
        expect(page).to have_content('Customers with item in basket: 2')
        expect(page).to have_content('Customers with item in basket: 1')
        expect(page).to have_content('Customers with item in basket: 3')
        expect('Customers with item in basket: 2').to appear_before('Topochico')
        expect('Customers with item in basket: 1').to appear_before('LaCroix')
      end
    end
  end
end
