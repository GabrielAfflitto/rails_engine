require 'rails_helper'

describe "Business analytics - Customers " do
  it "returns a merchant where the customer has conducted the most successful transactions" do
    customer = create(:customer)
    merchant1, merchant2 = create_list(:merchant, 2)
    invoice2 = create(:invoice, customer: customer, merchant: merchant1)
    invoice1 = create(:invoice, customer: customer, merchant: merchant1)
    invoice3 = create(:invoice, customer: customer, merchant: merchant2)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice2)
    transaction3 = create(:transaction, invoice: invoice1)

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer.favorite_merchant).to eq(merchant1)
  end
end
