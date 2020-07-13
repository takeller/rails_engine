class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.all
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params))
  end

  def update
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item.update(item_params))
  end

  def destroy
    render json: ItemSerializer.new(Item.delete(params[:id]))
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
