FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity 3
    unit_price 450
  end
end
