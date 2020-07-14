class Merchant < ApplicationRecord
  extend Searchable
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.find_by_attribute(search_params)
    search_params = format_params(search_params)

    where(search_params).first
  end
end
