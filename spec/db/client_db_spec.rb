require 'rails_helper'

describe ClientDB do
  let(:db)           { described_class.new }
  let(:fiscal_id)    { 9875 }
  let(:client_attrs) { { name: 'Pedro', email: 'pedro@pt.pt', fiscal_id: fiscal_id } }

  specify "finds client by fiscal id" do
    client = db.create_client(client_attrs)
    expect(db.find_client_by_fiscal_id(client.fiscal_id)).to eq client
  end

  specify "creates client" do
    db.create_client(client_attrs)
    expect(Client.count).to eq 1
    client = Client.last
    expect(client.name).to eq client_attrs[:name]
    expect(client.email).to eq client_attrs[:email]
    expect(client.fiscal_id).to eq client_attrs[:fiscal_id]
  end
end