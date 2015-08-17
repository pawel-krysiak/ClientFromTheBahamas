class ClientDB
  def create_client(attrs)
    Client.new.tap do |client|
      client.assign_attributes(attrs)
      client.save!
    end
  end

  def find_client_by_fiscal_id(fiscal_id)
    Client.where(fiscal_id: fiscal_id).first
  end
end