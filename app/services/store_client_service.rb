class StoreClientService
  InvoiceAlreadyExists = Class.new(StandardError)
  attr_accessor :client_db, :invoice_db
  
  def initialize(client_db, invoice_db)
    @client_db = client_db
    @invoice_db = invoice_db
  end

  def call(attrs)
    invoice = invoice_db.find_invoice_by_id(attrs[:invoice_id])
    raise InvoiceAlreadyExists, "invoice with invoice id #{attrs[:invoice_id]} already exists" unless invoice.nil?
    client = client_db.find_client_by_fiscal_id(attrs[:fiscal_id]) || client_db.create_client(attrs.except(:invoice_id))
    invoice_db.create_invoice_for_client(client.id, attrs[:invoice_id])
  end
end