class Item < ApplicationRecord
  extend Searchable
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_by_attribute(search_params)
    search_params = format_params(search_params)
    where(search_params).first
  end
end
