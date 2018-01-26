class Invoice < ApplicationRecord

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant

  def self.most_expensive(limit = 5)
    select("invoices.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue")
    .joins(:invoice_items, :transactions)
    .merge(Transaction.unscoped.successful)
    .group(:id)
    .order("revenue DESC").limit(limit)
  end

end
