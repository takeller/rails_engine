class AddMerchantToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :merchant, null: false, foreign_key: true
  end
end
