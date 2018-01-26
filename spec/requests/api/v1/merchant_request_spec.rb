require 'rails_helper'

describe "Merchants API" do
  context "Record endpoints" do
    it "returns a list of merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_success

      merchants = JSON.parse(response.body)

      expect(merchants.count).to eq(3)
    end

    it "can return one merchant by it's id" do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(id)
    end

    it "can find one merchant by it's name" do
      name = create(:merchant).name

      get "/api/v1/merchants/find?name=#{name}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["name"]).to eq(name)
    end

    it "can find one merchant by it's id" do
      id = create(:merchant).id

      get "/api/v1/merchants/find?id=#{id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(id)
    end

    it "can find all merchants by id" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      get "/api/v1/merchants/find_all?id=#{merchant1.id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first["id"]).to eq(merchant1.id)
    end

    it "can find all merchants by name" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      get "/api/v1/merchants/find_all?name=#{merchant1.name}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.count).to eq(2)
      expect(merchant.first["name"]).to eq(merchant1.name)
      expect(merchant.last["name"]).to eq(merchant2.name)
    end

    it "can find a random merchant" do
      create_list(:merchant, 3)

      get "/api/v1/merchants/random"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
    end
  end

  context "Relationship endpoints" do
    before :each do
      @merchant1, @merchant2 = create_list(:merchant, 2)
      @invoice1 = create(:invoice, merchant: @merchant1)
      @invoice2 = create(:invoice, merchant: @merchant1)
      @invoice3 = create(:invoice, merchant: @merchant1)
      @invoice4 = create(:invoice, merchant: @merchant2)
      @item1 = create(:item, merchant: @merchant1)
      @item2 = create(:item, merchant: @merchant1)
      @item3 = create(:item, merchant: @merchant1)
      @item4 = create(:item, merchant: @merchant2)
    end
    it "loads a collection of invoices associated with one merchant" do
      get "/api/v1/merchants/#{@merchant1.id}/invoices"

      invoices = JSON.parse(response.body)
      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end

    it "loads a collection of items associated with one merchant" do
      get "/api/v1/merchants/#{@merchant1.id}/items"

      items = JSON.parse(response.body)
      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end
end
