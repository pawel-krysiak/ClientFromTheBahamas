class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |invoice|
      invoice.integer :client_id
      invoice.integer :invoice_id, index: true, unique: true
      invoice.timestamps null: false
    end
  end
end
