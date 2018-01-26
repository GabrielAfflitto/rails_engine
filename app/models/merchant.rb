class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def total_revenue
    {revenue: (invoices.joins(:invoice_items, :transactions).where("transactions.result = 'success'").sum("invoice_items.quantity*invoice_items.unit_price")/ 100.0).to_s}
  end

  def total_revenue_by_date(date)
    date = Date.parse(params[:date])
    {revenue: (invoices.joins(:invoice_items, :transactions).where(:created_at => date.beginning_of_day..date.end_of_day).sum("invoice_items.quantity*invoice_items.unit_price")/ 100.0).to_s}
  end


  def favorite_customer
    customers.joins(invoices: [:transactions]).where("transactions.result = 'success'").group("customers.id").order("count(customers.id) DESC").first
  end

  def self.top_merchants_by_revenue(limit = 4)
    select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result = 'success'")
    .group(:id)
    .order("revenue DESC").limit(limit)
  end

  def self.top_merchants_by_items_sold(limit = 4)
    select("merchants.*, sum(invoice_items.quantity) AS total").joins(invoices:[:invoice_items, :transactions]).where("transactions.result = 'success'").group(:id).order("total DESC").limit(limit)
  end

end
