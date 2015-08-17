class InvoiceDB
  def create_invoice_for_client(client_id, invoice_id)
    Invoice.create!(client_id: client_id, invoice_id: invoice_id)
  end

  def find_invoice_by_id(invoice_id)
    Invoice.where(invoice_id: invoice_id).first
  end
end