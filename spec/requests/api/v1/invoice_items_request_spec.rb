require 'rails_helper'

describe "Invoice_items" do
  it "sends a list of invoice items" do
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(5)
  end

  it "sends back one invoice item" do
    invoice_item_id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{invoice_item_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(invoice_item_id)
  end
end
