class Api::V1::ItemsController < ApplicationController

  def index
    render json: OrderSerializer.new(Item.all)
  end

  def show
    render json: OrderSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: OrderSerializer.new(Item.create(item_params))
  end

  def update
    render json: OrderSerializer.new(Item.update(params[:id],) item_params)
  end

  def destroy
    render json: OrderSerializer.new(Item.delete(params[:id]))
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
