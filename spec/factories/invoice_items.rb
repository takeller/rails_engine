FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.number(digits: 1) }
    unit_price { Faker::Number.number(digits: 2).to_f }
    invoice
    item
  end
end
