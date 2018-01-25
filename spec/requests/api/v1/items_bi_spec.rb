require 'rails_helper'


describe "Business Intelligence- Items" do
  it "returns the top items by number sold" do
    invoice = create(:invoice)
    merchant= create(:merchant)
    item1= create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    invoice_item1 = create(:invoice_item, item: item2, invoice: invoice)
    invoice_item2 = create(:invoice_item, item: item1, invoice: invoice)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice)
    transaction = create(:transaction, invoice: invoice)


    get "/api/v1/items/most_items?quantity=2"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
    expect(Item.top_item_by_number_sold(2).first).to eq(item2)
  end
end
