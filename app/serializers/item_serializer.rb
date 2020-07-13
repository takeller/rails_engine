class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price

  attribute :merchant_id do |item|
    item.merchant_id
  end 
end
