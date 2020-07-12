class AddCustomerToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_reference :invoices, :customer, null: false, foreign_key: true
  end
end
