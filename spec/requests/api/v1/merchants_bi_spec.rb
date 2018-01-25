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

  it "returns customer with highest number of successful transactions" do
    merchant = create(:merchant)
    customer1,customer2 = create_list(:customer, 2)
    invoice1,invoice2,invoice3 = create_list(:invoice, 3, customer: customer1, merchant: merchant)
    invoice4,invoice5 = create_list(:invoice, 2, customer: customer2, merchant: merchant)
    create_list(:transaction, 2, result: "failed", invoice: invoice1)
    create_list(:transaction, 2, result: "failed", invoice: invoice2)
    create(:transaction, result: "success", invoice: invoice3)
    create(:transaction, result: "success", invoice: invoice4)
    create(:transaction, result: "success", invoice: invoice5)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant.favorite_customer).to eq(customer2)
  end

  it "returns top x merchants ranked by total revenue" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    invoice = create(:invoice, merchant: merchant)
    invoice2 = create(:invoice, merchant: merchant2)
    invoice3 = create(:invoice, merchant: merchant)
    transaction1 = create(:transaction, invoice: invoice)
    transaction2 = create(:transaction, invoice: invoice2)
    transaction3 = create(:transaction, invoice: invoice3)
    invoice_item1 = create(:invoice_item, invoice: invoice)
    invoice_item2 = create(:invoice_item, invoice: invoice2)
    invoice_item3 = create(:invoice_item, invoice: invoice2)
    invoice_item4 = create(:invoice_item, invoice: invoice3)

    get "/api/v1/merchants/most_revenue?quantity=2"

    merch = JSON.parse(response.body)
    expect(response).to be_success
    expect(Merchant.top_merchants_by_revenue(2).first).to eq(merchant)
    expect(Merchant.top_merchants_by_revenue(2).last).to eq(merchant2)
    expect(Merchant.top_merchants_by_revenue(2).last).to_not eq(merchant3)
  end

  it "returns top x merchants ranked by total items sold" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    invoice = create(:invoice, merchant: merchant)
    invoice2 = create(:invoice, merchant: merchant2)
    invoice3 = create(:invoice, merchant: merchant)
    transaction1 = create(:transaction, invoice: invoice)
    transaction2 = create(:transaction, invoice: invoice2)
    transaction3 = create(:transaction, invoice: invoice3)
    invoice_item1 = create(:invoice_item, invoice: invoice)
    invoice_item2 = create(:invoice_item, invoice: invoice2)
    invoice_item3 = create(:invoice_item, invoice: invoice2)
    invoice_item4 = create(:invoice_item, invoice: invoice3)

    get "/api/v1/merchants/most_items?quantity=2"

    merch = JSON.parse(response.body)
    expect(response).to be_success
    expect(Merchant.top_merchants_by_items_sold(2).first).to eq(merchant)
    expect(Merchant.top_merchants_by_items_sold(2).last).to eq(merchant2)
    expect(Merchant.top_merchants_by_items_sold(2).last).to_not eq(merchant3)
  end
end
