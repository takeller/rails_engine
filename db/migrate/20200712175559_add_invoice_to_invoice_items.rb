class AddInvoiceToInvoiceItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :invoice_items, :invoice, null: false, foreign_key: true
  end
end
