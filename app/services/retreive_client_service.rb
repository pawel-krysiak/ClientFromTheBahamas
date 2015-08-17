class RetreiveClientService
  UserNotFound = Class.new(StandardError)
  attr_accessor :invoice_db

  def initialize(invoice_db)
    @invoice_db = invoice_db
  end

  def call(invoice_id)
    invoice = invoice_db.find_invoice_by_id(invoice_id)
    raise UserNotFound, "no client found for invoice id #{invoice_id}" if invoice.nil?
    invoice.client
  end
end