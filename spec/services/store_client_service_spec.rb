require 'rails_helper'

describe StoreClientService do
  let(:client_db) { ClientDB.new }
  let(:invoice_db){ InvoiceDB.new }
  let(:service)   { described_class.new(client_db, invoice_db) }
  let(:call_attrs){ { invoice_id: 1111, fiscal_id: 8888, name: 'Pedro', email: 'pedro@pt.pt' } }

  specify "returns a proper error when invoice already exist" do
    client = client_db.create_client(call_attrs.except(:invoice_id))
    invoice_db.create_invoice_for_client(client.id, call_attrs[:invoice_id])
    expect{service.call(call_attrs)}.to raise_error StoreClientService::InvoiceAlreadyExists
  end

  specify "returns invoice id when succesfully stored data" do
    result = service.call(call_attrs)
    client = Client.last
    expect(client.fiscal_id).to eq call_attrs[:fiscal_id]
    expect(client.name).to eq call_attrs[:name]
    expect(client.email).to eq call_attrs[:email]
    expect(result).to eq Invoice.last
    expect(result.invoice_id).to eq call_attrs[:invoice_id]
  end
end