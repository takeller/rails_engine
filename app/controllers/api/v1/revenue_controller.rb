class Api::V1::RevenueController < ApplicationController

  def show
    start_date = params['start']
    end_date = (params['end'].to_date + 1).to_s

    data = Invoice.revenue_across_dates(start_date, end_date)
    render json: RevenueSerializer.new(data)
  end
end
