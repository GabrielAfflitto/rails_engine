require 'csv'

namespace :import do
  desc 'Import customers from csv file'
  task customers: :environment do
    file = "db/customers.csv"
      CSV.foreach(file, headers: true) do |row|
        Customer.create!(row.to_hash)
      end
  end

  desc 'Import invoice items from csv file'
  task invoice_items: :environment do
    file = "db/invoice_items.csv"
      CSV.foreach(file, headers: true) do |row|
        InvoiceItem.create!(row.to_hash)
      end
  end

  desc 'Import invoices from csv file'
  task invoices: :environment do
    file = "db/invoices.csv"
      CSV.foreach(file, headers: true) do |row|
        Invoice.create!(row.to_hash)
      end
  end

  desc 'Import items from csv file'
  task items: :environment do
    file = "db/items.csv"
      CSV.foreach(file, headers: true) do |row|
        Item.create!(row.to_hash)
      end
  end

  desc 'Import merchants from csv file'
  task merchants: :environment do
    file = "db/merchants.csv"
      CSV.foreach(file, headers: true) do |row|
        Merchant.create!(row.to_hash)
      end
  end

  desc 'Import transactions from csv file'
  task transactions: :environment do
    file = "db/transactions.csv"
      CSV.foreach(file, headers: true) do |row|
        Transaction.create!(row.to_hash)
      end
  end
end
