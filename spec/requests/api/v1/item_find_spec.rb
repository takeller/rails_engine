require 'rails_helper'

describe 'Items API' do
  it 'Can find an Item by name' do
    # name, description, price, timestamps
    create_list(:item, 5)
    test_item= create(:item, name: "Black Pen")

    get '/api/v1/items/find?name=Black+Pen'

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['name']).to eq(test_item.name)
  end

  it 'Can find an Item by description' do
    create_list(:item, 5)
    test_item = create(:item, description: "You can write with it")

    get '/api/v1/items/find?description=You+can+write+with+it'

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['description']).to eq(test_item.description)
  end

  it 'Can find an item by unit price' do
    create_list(:item, 5)
    test_item = create(:item, unit_price: 275.0)

    get '/api/v1/items/find?unit_price=275.0'

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['unit_price']).to eq(test_item.unit_price)
  end

  it 'Search parameter is case insesnsitive' do
    create_list(:item, 5)
    item1= create(:item, name: "Black Pen")

    get '/api/v1/items/find?name=blACK+PeN'

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['name']).to eq(item1.name)
  end

  it 'search parameter can be a partial match' do
    create_list(:item, 5)
    item1= create(:item, name: "Black Pen")

    get '/api/v1/items/find?name=ack'

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['name']).to eq(item1.name)
  end

  it 'can find an item based on multiple criteria' do
    create_list(:item, 5)
    item1= create(:item, name: "Black Pen")

    get "/api/v1/items/find?name=ack&created_at=#{item1.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['name']).to eq(item1.name)
  end

  it 'Can find multiple items' do
    create_list(:item, 10)
    fire_item1 = create(:item, name: 'Fire Nation Sword')
    fire_item2 = create(:item, name: 'Fire Nation Tea')

    get '/api/v1/items/find_all?name=fire'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items['data'][0]['attributes']['name']).to eq(fire_item1.name)
    expect(items['data'][1]['attributes']['name']).to eq(fire_item2.name)
  end
end
