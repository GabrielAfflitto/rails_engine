class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :status, :merchant_id, :customer_id

  has_many :transactions
  has_many :items
  belongs_to :customer
end
