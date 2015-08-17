require 'rails_helper'

describe InvoiceController do

  context "#show" do
    let(:invoice_id) { 1111 }
    let(:invoice_db) { InvoiceDB.new }
    let(:client_db)  { ClientDB.new }
    let(:client_data){ {name: 'Adam', email: 'adam@pt.pt', fiscal_id: 8888} }

    it "should return error when user is not found" do
      get :show, id: invoice_id
      expect(response).not_to be_success
      expect(response.status).to eq(404)
      expect(response.body).to eq({error: "no client found for invoice id #{invoice_id}"}.to_json)
    end

    it "should return client data when successfully retreived client" do
      client = client_db.create_client(client_data)
      invoice_db.create_invoice_for_client(client.id, invoice_id)
      get :show, id: invoice_id
      expect(response).to be_success
      expect(response.status).to eq 200
      expect(response.body).to eq client_data.to_json
    end
  end

  context "#create" do
    let(:invoice_id) { 1111 }
    let(:client_data){ {name: 'Adam', email: 'adam@pt.pt', fiscal_id: 8888} }
    let(:post_params){ client_data.merge!({ id: invoice_id }) }
    let(:invoice_db) { InvoiceDB.new }
    let(:client_db)  { ClientDB.new }

    it "should return error if invoice already exists" do
      stub_request(:post, 'http://localhost:3001/register').to_return(status: 200)
      client = client_db.create_client(client_data)
      invoice_db.create_invoice_for_client(client.id, invoice_id)
      post :create, post_params
      expect(response).not_to be_success
      expect(response.status).to eq 409
      expect(response.body).to eq({error: "invoice with invoice id #{invoice_id} already exists"}.to_json)
    end

    it "should return invoice id after adding client successfully" do
      stub_request(:post, 'http://localhost:3001/register').to_return(status: 200)
      post :create, post_params
      expect(response).to be_success
      expect(response.status).to eq 200
      expect(response.body).to eq({invoice_id: invoice_id}.to_json)
    end

    it "should return proper error when external service is not aviliable" do
      stub_request(:any, 'http://localhost:3001/register').to_raise(Errno::ECONNREFUSED)
      post :create, post_params
      expect(response.status).to eq 404
      expect(response.body).to eq({error: 'could not register in external service'}.to_json)
    end
  end


end