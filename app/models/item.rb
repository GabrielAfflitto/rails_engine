class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope {order(:id)}

  def self.top_items_by_revenue(limit =4)
    select("items.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(invoices: [:invoice_items, :transactions]).where("transactions.result = 'success'").group(:id).order("revenue DESC").limit(limit)
  end

end
