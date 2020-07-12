class AddTimestampsToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :created_at, :datetime, null: false
    add_column :invoices, :updated_at, :datetime, null: false
  end
end
