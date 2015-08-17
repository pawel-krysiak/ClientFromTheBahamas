require 'net/http'
require 'uri'
class InvoiceController < ApplicationController
  def index
  end

  def show
    invoice_db = InvoiceDB.new
    service = RetreiveClientService.new(invoice_db)
    render json: service.call(params.fetch(:id)), only: [:name, :email, :fiscal_id]
  rescue RetreiveClientService::UserNotFound
    render json: {error: $!.message}, status: :not_found
  end

  def create
    attrs = {
      invoice_id: params.fetch(:id),
      fiscal_id:  params.fetch(:fiscal_id),
      name:       params.fetch(:name),
      email:      params.fetch(:email)
    }
    post_params = {
        invoice:    params.fetch(:id),
        fiscal_id:  params.fetch(:fiscal_id),
        name:       params.fetch(:name),
        email:      params.fetch(:email)
    }
    service = StoreClientService.new(ClientDB.new, InvoiceDB.new)
    result = service.call(attrs)
    send_request(post_params)
    render json: result, only: [:invoice_id], status: :ok
  rescue Errno::ECONNREFUSED
    render json: {error: 'could not register in external service'}, status: 404
  rescue StoreClientService::InvoiceAlreadyExists
    render json: {error: $!.message}, status: 409
  end

  private
  def send_request(params)
    RestClient.post 'http://localhost:3001/register', params
  end

end
