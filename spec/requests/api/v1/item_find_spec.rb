require 'rails_helper'

describe 'Items API' do
  it 'Can find an Item' do
    # name, description, price, timestamps
    create_list(:item, 5)
    item1= create(:item, name: "Black Pen")
    item2 = create(:item, description: "You can write with it")
    item3 = create(:item, unit_price: 25.0)

    get '/api/v1/items/find?name=Black+Pen'

    expect(response).to be_successful

    item = JSON.pase(response.body)

    expect(item['data']['attributes']['name']).to eq(item1.name)

    get '/api/v1/items/find?description=You+can+write+with+it'

    expect(response).to be_successful

    item = JSON.pase(response.body)

    expect(item['data']['attributes']['description']).to eq(item2.description)

    get '/api/v1/items/find?unit_price=25.0'

    expect(response).to be_successful

    item = JSON.pase(response.body)

    expect(item['data']['attributes']['description']).to eq(item2.description)
  end

  it 'Search parameter is case insesnsitive' do
    create_list(:item, 5)
    item1= create(:item, name: "Black Pen")

    get '/api/v1/items/find?name=blACK+PeN'

    expect(response).to be_successful

    item = JSON.pase(response.body)

    expect(item['data']['attributes']['name']).to eq(item1.name)
  end

  it 'search parameter can be a partial match' do
    create_list(:item, 5)
    item1= create(:item, name: "Black Pen")

    get '/api/v1/items/find?name=ack'

    expect(response).to be_successful

    item = JSON.pase(response.body)

    expect(item['data']['attributes']['name']).to eq(item1.name)
  end

  it 'can find an item based on multiple criteria' do
    create_list(:item, 5)
    item1= create(:item, name: "Black Pen")

    get "/api/v1/items/find?name=ack&created_at=#{item1.created_at}"

    expect(response).to be_successful

    item = JSON.pase(response.body)

    expect(item['data']['attributes']['name']).to eq(item1.name)
  end
end
