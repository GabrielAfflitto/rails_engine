FactoryBot.define do
  factory :transaction do
    credit_card_number "4563849302031045"
    credit_card_expiration_date "3/15/18"
    result "success"
    invoice
  end
end
