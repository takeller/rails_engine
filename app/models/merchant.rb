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

  def self.revenue_across_dates(start_date, end_date)
    select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [ :invoice_items, :transactions ])
    .merge(Transaction.successful)
    .where("invoices.created_at >= ?  and invoices.created_at < ?", "#{start_date}", "#{end_date}")
  end

  def total_revenue(merch_id)
     select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
     .joins(invoices: [ :invoice_items, :transactions ])
     .merge(Transaction.successful)
     .where("merchants.id = #{merch_id}")
     .group(:id)
  end

end

# .where(transactions: { result: "success" })

# Merchant.select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").joins(invoices: [:invoice_items, :transactions]).where(transactions: { result: "success" }).group(:id).order("revenue DESC").limit(10).to_sql
