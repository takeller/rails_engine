class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items

  def self.revenue_across_dates(start_date, end_date)
    select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where("invoices.created_at >= ?  and invoices.created_at <= ?", "#{start_date}", "#{end_date}")[0]
  end
end
