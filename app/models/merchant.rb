class Merchant < ApplicationRecord
  extend Searchable
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.find_by_attribute(search_params)
    search_params = format_params(search_params)

    where(search_params).first
  end

  def self.most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: { result: "success" })
      .group(:id)
      .order("revenue DESC")
      .limit(quantity)
  end
end


# Merchant.select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").joins(invoices: [:invoice_items, :transactions]).where(transactions: { result: "success" }).group(:id).order("revenue DESC").limit(10).to_sql
