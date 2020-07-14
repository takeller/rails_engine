require 'rails_helper'

describe 'Merchants API' do
  it 'Can find a merchant based on name' do
    create_list(:merchant, 10)
    create(:merchant, name: 'Aang')

    get '/api/v1/merchants/find?name=Aang'

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['name']).to eq('Aang')
  end

  it 'Search parameter is case insensitive' do
    create_list(:merchant, 10)
    create(:merchant, name: 'Aang')

    get '/api/v1/merchants/find?name=AAnG'

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['name']).to eq('Aang')
  end

  it 'Search parameter can be a partial match' do
    create_list(:merchant, 10)
    create(:merchant, name: 'Aang')

    get '/api/v1/merchants/find?name=ng'

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['name']).to eq('Aang')
  end

  it 'Can find a merchant based on multiple criteria' do
    create_list(:merchant, 10)
    aang = create(:merchant, name: 'Aang')

    get "/api/v1/merchants/find?name=ng&created_at=#{aang.created_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['name']).to eq('Aang')
  end
end
