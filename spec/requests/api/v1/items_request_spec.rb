require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(3)
  end

  it 'can get one item by its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item['data']['id']).to eq(id.to_s)
  end

  it 'can create a new item' do
    merchant = create(:merchant)
    item_params = { name: "Earth Scroll", description: "Learn the way of stone", unit_price: 27.50, merchant_id: merchant.id}

    post '/api/v1/items', params: item_params
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
  end

  it 'can update an item' do
    id = create(:item).id
    previous_unit_price = Item.last.unit_price
    item_params = { unit_price: 30.25 }

    put "/api/v1/items/#{id}", params: item_params
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.unit_price).to_not eq(previous_unit_price)
  end

  it 'can destroy an item' do
    item = create(:item)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
