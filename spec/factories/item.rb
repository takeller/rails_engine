FactoryBot.define do
  factory :item do
    name { 'Water Scroll' }
    description { 'Learn the secrets of the Water Tribe.' }
    unit_price { 25.0 }
    merchant
  end
end
