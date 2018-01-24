require 'rails_helper'


describe "Business Intelligence- merchants" do
  it "sums revenue for a single merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)
    invoice_items = create(:invoice_item, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)
    transaction2 = create(:transaction, invoice: invoice)
    transaction3 = create(:transaction, invoice: invoice)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.total_revenue).to eq({revenue: "40.5"})
  end
end
