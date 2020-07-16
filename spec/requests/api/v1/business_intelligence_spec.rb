require 'rails_helper'

describe 'Merchants API' do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)

    @item1 = create(:item, merchant: @merchant1, unit_price: 10.0)
    @item2 = create(:item, merchant: @merchant1, unit_price: 10.0)
    @item3 = create(:item, merchant: @merchant2, unit_price: 10.0)
    @item4 = create(:item, merchant: @merchant2, unit_price: 10.0)
    @item5 = create(:item, merchant: @merchant3, unit_price: 10.0)
    @item6 = create(:item, merchant: @merchant3, unit_price: 10.0)
    @item7 = create(:item, merchant: @merchant4, unit_price: 10.0)
    @item8 = create(:item, merchant: @merchant4, unit_price: 10.0)
    @item9 = create(:item, merchant: @merchant5, unit_price: 10.0)
    @item10 = create(:item, merchant: @merchant5, unit_price: 10.0)

    @invoice1 = create(:invoice, merchant: @merchant1, created_at: '2020-05-02 00:00:00 UTC')
    @invoice2 = create(:invoice, merchant: @merchant1, created_at: '2020-05-02 00:00:00 UTC')
    @invoice3 = create(:invoice, merchant: @merchant2, created_at: '2020-05-04 00:00:00 UTC')
    @invoice4 = create(:invoice, merchant: @merchant2, created_at: '2020-05-04 00:00:00 UTC')
    @invoice5 = create(:invoice, merchant: @merchant3, created_at: '2020-05-12 00:00:00 UTC')
    @invoice6 = create(:invoice, merchant: @merchant4, created_at: '2020-05-25 00:00:00 UTC')
    @invoice7 = create(:invoice, merchant: @merchant4, created_at: '2020-05-28 00:00:00 UTC')

    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 5, unit_price: 10.0)
    @invoice_item2 = create(:invoice_item, invoice: @invoice1, item: @item2, quantity: 5, unit_price: 10.0)
    @invoice_item3 = create(:invoice_item, invoice: @invoice2, item: @item1, quantity: 5, unit_price: 10.0)
    @invoice_item4 = create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 5, unit_price: 10.0)
    @invoice_item5 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 5, unit_price: 10.0)
    @invoice_item6 = create(:invoice_item, invoice: @invoice4, item: @item3, quantity: 5, unit_price: 10.0)
    @invoice_item7 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 5, unit_price: 10.0)
    @invoice_item8 = create(:invoice_item, invoice: @invoice5, item: @item5, quantity: 50, unit_price: 10.0)
    @invoice_item9 = create(:invoice_item, invoice: @invoice6, item: @item7, quantity: 5, unit_price: 10.0)
    @invoice_item10 = create(:invoice_item, invoice: @invoice7, item: @item8, quantity: 500, unit_price: 0.005)

    @transaction1 = create(:transaction, invoice: @invoice1)
    @transaction2 = create(:transaction, invoice: @invoice2)
    @transaction3 = create(:transaction, invoice: @invoice3)
    @transaction4 = create(:transaction, invoice: @invoice4)
    @transaction5 = create(:transaction, invoice: @invoice5)
    @transaction6 = create(:transaction, invoice: @invoice6)
    @transaction7 = create(:transaction, invoice: @invoice7)

  end
  it 'Can find the merchants with the most revenue' do
    get '/api/v1/merchants/most_revenue?quantity=3'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants['data'][0]['id'].to_i).to eq(@merchant3.id)
    expect(merchants['data'][1]['id'].to_i).to eq(@merchant1.id)
    expect(merchants['data'][2]['id'].to_i).to eq(@merchant2.id)
  end

  it 'Can find the merchants with the most items sold' do
    get '/api/v1/merchants/most_items?quantity=2'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants['data'][0]['id'].to_i).to eq(@merchant4.id)
    expect(merchants['data'][1]['id'].to_i).to eq(@merchant3.id)
  end

  it 'Can find the revenue for a single merchant' do
    get "/api/v1/merchants/#{@merchant3.id}/revenue"

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue['data']['attributes']['revenue']).to eq(500.0)
  end

  it 'Can find the revenue for all merchants across a date range' do
    get '/api/v1/revenue?start=2020-05-10&end=2020-05-26'

    revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(revenue['data']['attributes']['revenue']).to eq(550.0)
  end
end
