class RevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |object|
    object.revenue
  end
end
