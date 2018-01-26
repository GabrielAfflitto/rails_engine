class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope {order(:id)}

  def self.top_items_by_revenue(limit =4)
    unscoped.select("items.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(invoices: [:invoice_items, :transactions]).where("transactions.result = 'success'").group(:id).order("revenue DESC").limit(limit)
  end

  def self.top_item_by_number_sold(limit = 4)
    unscoped.select("items.*, sum(invoice_items.quantity) AS total").joins(invoices:[ :transactions]).where("transactions.result = 'success'").group(:id).order("total DESC").limit(limit)
  end

  def best_day
    invoices.joins(:invoice_items, :transactions).where("transactions.result = 'success'").group(:id).order("sum(invoice_items.quantity*invoice_items.unit_price) DESC, invoices.created_at DESC").first.created_at
  end

end
