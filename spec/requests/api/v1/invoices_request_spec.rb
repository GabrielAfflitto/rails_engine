require 'rails_helper'

describe "Invoices" do
  it "sends a list of invoices" do
    create_list(:invoice, 5)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(5)
  end

  it "sends back one invoice" do
    invoice_id = create(:invoice).id

    get "/api/v1/invoices/#{invoice_id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(invoice_id)
  end

  it "can find one invoice by status" do
    invoice_status = create(:invoice).status

    get "/api/v1/invoices/find?status=#{invoice_status}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["status"]).to eq(invoice_status)
  end

  it "can find all invoices by parameters" do
    invoice1, invoice2, invoice3 = create_list(:invoice, 3)

    get "/api/v1/invoices/find_all?id=#{invoice1.id}"

  invoice = JSON.parse(response.body)

  expect(response).to be_successful
  expect(invoice.first["id"]).to eq(invoice1.id)
  end

  it "can find a random invoice" do
    create_list(:invoice, 4)

    get "/api/v1/invoices/random"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
  end

  context "Relationship endpoints" do
    before :each do
      @invoice = create(:invoice)

      @transaction1 = create(:transaction, invoice: @invoice)
      @transaction2 = create(:transaction, invoice: @invoice)
    end

    it "loads a collection of transactions associated with one merchant" do
      get "/api/v1/invoices/#{@invoice.id}/transactions"

      transactions = JSON.parse(response.body)
      expect(response).to be_success
      expect(transactions.count).to eq(2)
    end
  end
end
