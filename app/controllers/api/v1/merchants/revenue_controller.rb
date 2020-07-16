class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    merchants = Merchant.most_revenue(params['quantity'])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    revenue = merchant.total_revenue
    return_hash = {
      'data' => {
        'id' => 'null',
        'attributes' => {
          'revenue' => revenue
        }
      }
    }
    render json: return_hash
  end
end
