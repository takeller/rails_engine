require 'csv'

desc 'Seed database with data imported from csv files'
task :import_csv do
  Rake::Task["db:reset"].invoke
  Rake::Task["db:migrate"].invoke

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

  # file_names = Dir.children("../rails_engine/lib/seeds")
    file_names = ["merchants.csv", "items.csv", "customers.csv", "invoices.csv", "invoice_items.csv", "transactions.csv"]

  file_names.each do |file_name|
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{file_name}"))
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      create_object(row, file_name)
    end
    puts "Imported from #{file_name}"
  end
end

def create_object(row, file_name)
  case file_name
  when 'customers.csv'
    create_customer(row)
  when 'invoice_items.csv'
    create_invoice_item(row)
  when 'invoices.csv'
    create_invoice(row)
  when 'items.csv'
    create_item(row)
  when 'merchants.csv'
    create_merchant(row)
  when 'transactions.csv'
    create_transaction(row)
  end
end

def create_invoice(row)
  Invoice.create(
                  {
                    customer_id: row['customer_id'],
                    merchant_id: row['merchant_id'],
                    status: row['status'],
                  }
                )
end

def create_invoice_item(row)
  InvoiceItem.create(
                        {
                          item_id: row['item_id'],
                          invoice_id: row['invoice_id'],
                          quantity: row['quantity'],
                          unit_price: row['unit_price'].insert(-3, '.')
                        }
                      )
end

def create_customer(row)
  Customer.create(
                    {
                      first_name: row['first_name'],
                      last_name: row['last_name']
                    }
                  )
end

def create_merchant(row)
  Merchant.create(
                    {
                      name: row['name']
                    }
                  )
end

def create_transaction(row)
  Transaction.create(
                      {
                        invoice_id: row['invoice_id'],
                        credit_card_number: row['credit_card_number'],
                        credit_card_expiration_date: row['credit_card_expiration_date'],
                        result: row['result']
                      }
                    )
end

def create_item(row)
  Item.create(
                {
                  name: row['name'],
                  description: row['description'],
                  unit_price: row['unit_price'].insert(-3, '.'),
                  merchant_id: row['merchant_id'],
                }
              )
end
