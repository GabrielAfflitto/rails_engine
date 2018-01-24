class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def total_revenue
    {revenue: (invoices.joins(:invoice_items, :transactions).where("transactions.result = 'success'").sum("invoice_items.quantity*invoice_items.unit_price")/ 100.0).to_s}
  end

end
