require 'rails_helper'

describe InvoiceDB do
  let(:db)         { described_class.new }
  let(:client_id)  { 1111 }
  let(:invoice_id) { 4566 }

  specify "finds invoice by id" do
    invoice = db.create_invoice_for_client(client_id, invoice_id)
    expect(db.find_invoice_by_id(invoice_id)).to eq invoice
  end

  specify "creates invoice for client" do
    db.create_invoice_for_client(client_id, invoice_id)
    expect(Invoice.count).to eq 1
    invoice = Invoice.last
    expect(invoice.invoice_id).to eq invoice_id
    expect(invoice.client_id).to eq client_id
  end
end