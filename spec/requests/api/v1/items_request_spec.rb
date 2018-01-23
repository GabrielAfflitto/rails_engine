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
end
