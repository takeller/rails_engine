require 'rails_helper'

describe 'Merchants API' do
  it 'Can find a merchant based on a single criteria' do
    create_list(:merchant, 10)
    create(:merchant, name: 'Sakka')

    get '/api/v1/merchants/find?name=Sakka'

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data'].count).to eq(1)
    expect(merchant['data']['attributes']['name']).to eq('Sakka')
  end

  it 'Search parameter is case insensitive' do

  end

  it 'Can find a merchant based on multiple criteria' do

  end
end
