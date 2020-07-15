class Api::V1::Items::SearchController < ApplicationController

  def index
    item = Item.find_by_attribute(search_params)
    render json: ItemSerializer.new(item)
  end

  def show
    item = Item.find_by_attribute(search_params).first
    render json: ItemSerializer.new(item)
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end
end
