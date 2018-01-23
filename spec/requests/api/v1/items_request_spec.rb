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

  it "can find all items by parameters" do
    item1, item2, item3 = create_list(:item, 3)

    get "/api/v1/items/find_all?id =#{item1.id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)
    expect(item.first["id"]).to eq(item1.id)
  end

  it "can find a random item" do
    create_list(:item, 4)

    get "/api/v1/items/random"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
  end
end
