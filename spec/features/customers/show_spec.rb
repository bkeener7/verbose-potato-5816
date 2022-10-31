require 'rails_helper'

RSpec.describe 'customers' do
  before :each do
    @supermarket1 = Supermarket.create!(name: 'Costco', location: 'Timnath')
    @supermarket2 = Supermarket.create!(name: 'Whole Foods', location: 'Fort Collins')
    @customer1 = Customer.create!(name: 'Bruce Wayne')
    @customer2 = Customer.create!(name: 'Barack Obama')
    @item1 = Item.create!(name: 'Fresca', price: 1, supermarket_id: @supermarket1.id, customer_id: @customer1.id)
    @item2 = Item.create!(name: 'Topochico', price: 2, supermarket_id: @supermarket1.id, customer_id: @customer1.id)
    @item3 = Item.create!(name: 'LaCroix', price: 5, supermarket_id: @supermarket2.id, customer_id: @customer2.id)
  end
  describe 'customers show page' do
    it 'sees customers name and list of its items' do
      visit "customers/#{@customer1.id}"

      expect(current_path).to eq("/customers/#{@customer1.id}")

      within '#customer' do
        expect(page).to have_content('Bruce Wayne')
        expect(page).to_not have_content('Barack Obama')
      end
      within '#items' do
        expect(page).to have_content('Fresca')
        expect(page).to have_content('Topochico')
        expect(page).to_not have_content('LaCroix')
      end
    end

    it 'also has list of item name, price and name of supermarket it belongs to' do
      visit "customers/#{@customer1.id}"

      within '#items' do
        expect(page).to have_content(1)
        expect(page).to have_content(2)
        expect(page).to_not have_content(5)
        expect(page).to have_content('Costco')
        expect(page).to_not have_content('Whole Foods')
      end
    end

    it 'sees a form to add an item to this customer' do
      visit "customers/#{@customer1.id}"
      within '#add_new_item' do
        expect(page).to have_selector(:css, 'form')
        expect(find('form')).to have_content('Item id:')
        expect(page).to have_button('Add Item')
      end
    end

    it 'can fill in existing item ID in the form and have it shown on the customers show page' do
      visit "customers/#{@customer1.id}"

      within '#items' do
        expect(page).to have_content(1)
        expect(page).to have_content(2)
        expect(page).to_not have_content(5)
        expect(page).to have_content('Costco')
        expect(page).to_not have_content('Whole Foods')
        expect(page).to have_content('Fresca')
        expect(page).to have_content('Topochico')
        expect(page).to_not have_content('LaCroix')
      end

      within '#add_new_item' do
        fill_in('item_id', with: @item3.id)
        click_button('Add Item')
      end

      expect(current_path).to eq("/customers/#{@customer1.id}")

      within '#items' do
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
  end
end
