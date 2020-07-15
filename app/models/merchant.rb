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
      .merge(Transaction.successful)
      .group(:id)
      .order("revenue DESC")
      .limit(quantity)
  end

  def self.most_items_sold(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
    .joins( invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("items_sold DESC")
    .limit(quantity)
  end

  def total_revenue
     select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
     .joins(invoices: [ :invoice_items, :transactions ])
     .merge(Transaction.successful)
     .where("merchants.id = 2")
     .group(:id)
  end
end

# .where(transactions: { result: "success" })

# Merchant.select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").joins(invoices: [:invoice_items, :transactions]).where(transactions: { result: "success" }).group(:id).order("revenue DESC").limit(10).to_sql
