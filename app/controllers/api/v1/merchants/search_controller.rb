class Api::V1::Merchants::SearchController < ApplicationController

  def index
    merchant = Merchant.find_by_attribute(search_params)
    render json: MerchantSerializer.new(merchant)
  end

  def show
    merchant = Merchant.find_by_attribute(search_params).first
    render json: MerchantSerializer.new(merchant)
  end

  private

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end
end
