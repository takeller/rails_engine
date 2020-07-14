require 'rails_helper'

describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'Class methods' do
    it '.find_by_attribute' do
      create_list(:merchant, 3)
      create(:merchant, name: 'Sakka')

      merchant = Merchant.find_by_attribute({name: 'Sakka'})

      expect(merchant.first.name).to eq('Sakka')
    end
  end
end
