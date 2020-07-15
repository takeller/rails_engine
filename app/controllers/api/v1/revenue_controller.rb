class Api::V1::RevenueController < ApplicationController

  def show
    revenue = Merchant.revenue_across_dates(params['start'], params['end'])
    binding.pry
    render json: revenue
  end
end
