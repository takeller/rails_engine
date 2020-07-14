require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data'].count).to eq(3)
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant['data']['id']).to eq(id.to_s)
  end

  it 'can create a new merchant' do
    merchant = create(:merchant)
    merchant_params = { name: "Aang" }

    post '/api/v1/merchants', params: merchant_params
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it 'can update an merchant' do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: 'Sakka' }

    put "/api/v1/merchants/#{id}", params: merchant_params
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
    expect(merchant.name).to_not eq(previous_name)
  end

  it 'can destroy an merchant' do
    merchant = create(:merchant)

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_successful
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can get all items associated with a merchant' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant, name: 'Sakka')

    5.times do
      create(:item, merchant_id: merchant1.id)
    end
    3.times do
      create(:item, merchant_id: merchant2.id)
    end

    item_ids = merchant1.items.map { |item| item.id }

    get "/api/v1/merchants/#{merchant1.id}/items"

    items = JSON.parse(response.body)
    response_ids = items['data'].map { |item| item['attributes']['id'] }

    expect(response).to be_successful
    expect(items['data'].count).to eq(5)
    expect(response_ids).to eq(item_ids)
  end
end
