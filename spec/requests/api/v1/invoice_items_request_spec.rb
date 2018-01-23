require 'rails_helper'

describe "Invoice_items" do
  it "sends a list of invoice items" do
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(5)
  end
end
