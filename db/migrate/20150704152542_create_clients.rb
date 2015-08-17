class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |client|
      client.string :name
      client.string :email
      client.integer :fiscal_id, unique: true, :limit => 10
      client.timestamps null: false
    end
  end
end
