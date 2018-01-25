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

  it "can find one invoice item by quantity" do
    invoice_item_quantity = create(:invoice_item).quantity

    get "/api/v1/invoice_items/find?quantity=#{invoice_item_quantity}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)
    expect(invoice_item["quantity"]).to eq(invoice_item_quantity)
  end

  it "can find a random invoice item" do
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/random"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
  end

  it "can find all invoice items by a certain attribute" do
    invoice_item1,
    invoice_item2,
    invoice_item3,
    invoice_item4,
    invoice_item5 = create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item1.quantity}"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)
    expect(invoice_item.first["quantity"]).to eq(invoice_item1.quantity)
    expect(invoice_item.count).to eq(5)

    get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item1.unit_price}"

    expect(response).to be_successful
    invoice_item = JSON.parse(response.body)
    expect(invoice_item.first["unit_price"]).to eq((invoice_item1.unit_price/100.0).to_s)
    expect(invoice_item.count).to eq(5)
  end

  context "Relationship endpoints" do
    before :each do
      @invoice = create(:invoice)
      @item = create(:item)
      @invoice_item = create(:invoice_item, invoice: @invoice, item: @item)
    end

    it "loads the invoice associated with one invoice_item" do

      get "/api/v1/invoice_items/#{@invoice_item.id}/invoice"

      invoice = JSON.parse(response.body)
      expect(response).to be_success
      expect(invoice["id"]).to eq(@invoice.id)
    end

    it "loads the invoice associated with one invoice_item" do

      get "/api/v1/invoice_items/#{@invoice_item.id}/item"

      item = JSON.parse(response.body)
      expect(response).to be_success
      expect(item["name"]).to eq(@item.name)
    end
  end
end
