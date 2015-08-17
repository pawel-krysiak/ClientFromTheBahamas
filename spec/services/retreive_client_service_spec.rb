require 'rails_helper'

describe RetreiveClientService do
  let(:invoice_db) { InvoiceDB.new }
  let(:client_db)  { ClientDB.new }
  let(:service)    { described_class.new(invoice_db) }
  let(:invoice_id) { 1111 }
  let(:client_data){ {name: 'Adam', email: 'adam@pt.pt', fiscal_id: 8888} }

  specify "returns user data when user was found" do
    client = client_db.create_client(client_data)
    invoice_db.create_invoice_for_client(client.id, invoice_id)
    result = service.call(invoice_id)
    expect(result).to eq client
  end

  specify "returns a proper error when user not found" do
    expect{ service.call(invoice_id) }.to raise_error(RetreiveClientService::UserNotFound)
  end
end