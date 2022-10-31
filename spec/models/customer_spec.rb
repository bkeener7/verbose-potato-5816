require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :customer_baskets }
    it { should have_many(:items).through(:customer_baskets) }
  end
end
