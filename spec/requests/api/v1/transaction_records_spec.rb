require 'rails_helper'

describe "Transactions API" do
  it "returns a list of transactions" do
    customer =create (:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction1 = create(:transaction, invoice:invoice)
    transaction2 = create(:transaction, invoice:invoice)
    transaction3 = create(:transaction, invoice:invoice)


    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
  end

  it "can return one transaction by it's id" do
    customer =create (:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    id = create(:transaction, invoice: invoice).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end
end
