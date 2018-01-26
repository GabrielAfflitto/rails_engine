class Invoice < ApplicationRecord

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant

  # default_scope {order(:id)}

  def self.most_expensive(limit = 5)
    select("invoices.*, sum(invoice_items.quantity*invoice_items.unit_price) AS revenue").joins(:invoice_items, :transactions).merge(Transaction.unscoped.successful).group(:id).order("revenue DESC").limit(limit)
  end

  def self.all_revenue_for_date(date)
    selected_date = DateTime.parse(date)

    {total_revenue: (joins(:invoice_items, :transactions)
      .where("transactions.result = 'success'")
      .where("invoices.created_at" => selected_date.beginning_of_day..selected_date.end_of_day)
      .sum("invoice_items.quantity*invoice_items.unit_price")/ 100.0).to_s}
  end
end
