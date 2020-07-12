require 'csv'
require 'pry'
desc 'Seed database with data imported from csv files'
task :import_csv do
  # Clear Dev database
  Rake::Task["db:reset"].invoke
  Rake::Task["db:migrate"].invoke

  file_names = Dir.children("../rails_engine/lib/seeds")

  # Load from CSV data
  file_names.each do |file_name|
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{file_name}"))
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      create_object(row, file_name)
    end
  end

  # Convert prices cents -> dollars

  # Seed data base

  # Reset primary key dequence for each imported table
end

def create_object(row, file_name)

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
  Invoice_item.create(
                        {
                          item_id: row['item_id'],
                          invoice_id: row['invoice_id'],
                          quantity: row['quantity'],
                          unit_price: row['unit_price']
                        }
                      )
end

def create_customers(row)
  Customer.create(
                    {
                      first_name: row['first_name'],
                      last_name: row['last_name']
                    }
                  )
end

def create_merchants(row)
  Merchant.create(
                    {
                      name: row['name']
                    }
                  )
end

def create_transactions(row)
  Transaction.create(
                      {
                        invoice_id: row['invoice_id'],
                        credit_card_number: row['credit_card_number'],
                        credit_card_expiration_date: row['credit_card_expiration_date'],
                        result: row['result']
                      }
                    )
end

def create_items(row)
  Item.create(
                {
                  name: row['name'],
                  description: row['description'],
                  unit_price: row['unit_price'],
                  merchant_id: row['merchant_id'],
                }
              )
end
