require 'rails_helper'

describe "Items" do
  it "sends a list of items" do
    create_list(:item, 4)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items.count).to eq(4)
  end

  it "sends back one item" do
    item_id = create(:item).id

    get "/api/v1/items/#{item_id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(item_id)
  end

  it "can find one item by name" do
    item_name = create(:item).name

    get "/api/v1/items/find?name=#{item_name}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["name"]).to eq(item_name)
  end

  it "can find one item by id" do
    item_id = create(:item).id

    get "/api/v1/items/find?id=#{item_id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(item_id)
  end

  it "can find all items by parameters" do
    item1, item2, item3 = create_list(:item, 3)

    get "/api/v1/items/find_all?id =#{item1.id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item.first["id"]).to eq(item1.id)
  end

  it "can find all items by name" do
    item1, item2, item3 = create_list(:item, 3)

    get "/api/v1/items/find_all?name =#{item1.name}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item.first["name"]).to eq(item1.name)
    expect(item.last["name"]).to eq(item2.name)
    expect(item.count).to eq(3)
  end

  it "can find all items by unit price" do
    item1, item2, item3 = create_list(:item, 3)

    get "/api/v1/items/find_all?unit_price =#{item1.unit_price}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item.first["unit_price"]).to eq("1.0")
    expect(item.last["unit_price"]).to eq("1.0")
    expect(item.count).to eq(3)
  end

  it "can find a random item" do
    create_list(:item, 4)

    get "/api/v1/items/random"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
  end

  context "Relationship endpoints" do
    before :each do
      @merchant = create(:merchant)
      @invoice = create(:invoice)
      @item = create(:item, merchant: @merchant)
      @invoice_item = create(:invoice_item, item: @item)
      @invoice_item2 = create(:invoice_item, item: @item)
      @invoice_item3 = create(:invoice_item, item: @item)
    end

    it "loads collection of invoice_items associated with one item" do

      get "/api/v1/items/#{@item.id}/invoice_items"

      invoice_items = JSON.parse(response.body)
      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
    end

    it "loads the merchant associated with one item" do

      get "/api/v1/items/#{@item.id}/merchant"

      merchant = JSON.parse(response.body)
      expect(response).to be_success
      expect(merchant["name"]).to eq(@merchant.name)
      end
  end
end
