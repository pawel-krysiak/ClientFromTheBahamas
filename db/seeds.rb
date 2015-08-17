# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
c = Client.create(name: 'Bob', email: 'bob@bob.com', fiscal_id: 999999999)
i = Invoice.create(invoice_id: 1234)
c.invoices << i

