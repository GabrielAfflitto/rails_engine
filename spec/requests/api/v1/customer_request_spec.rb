require 'rails_helper'

describe "Customers API" do
  context "Record endpoints" do
    it "returns a list of customers" do
      create_list(:customer, 3)

      get '/api/v1/customers'

      expect(response).to be_success

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(3)
    end

    it "can return one customer by it's id" do
      id = create(:customer).id

      get "/api/v1/customers/#{id}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(id)
    end

    it "can find one customer by it's name" do
      name = create(:customer).first_name

      get "/api/v1/customers/find?first_name=#{name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["first_name"]).to eq(name)
    end

    it "can find all customers by parameters" do
      merchant1 = create(:customer)
      merchant2 = create(:customer)

      get "/api/v1/customers/find_all?id=#{merchant1.id}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer.first["id"]).to eq(merchant1.id)
    end

    it "can find a random merchant" do
      create_list(:merchant, 3)

      get "/api/v1/customers/random"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
    end
  end

  context "Relationship endpoints" do
    it "loads a collection of invoices associated with one customer" do
      customer1, customer2 = create_list(:customer, 2)
      invoice1 = create(:invoice, customer: customer1)
      invoice2 = create(:invoice, customer: customer1)
      invoice3 = create(:invoice, customer: customer1)
      invoice4 = create(:invoice, customer: customer2)

      get "/api/v1/customers/#{customer1.id}/invoices"

      invoices = JSON.parse(response.body)
      expect(response).to be_successful
      expect(customer1.invoices.count).to eq(3)
      expect(customer1.invoices.first.id).to eq(invoice1.id)
      expect(customer1.invoices[1].id).to eq(invoice2.id)
      expect(customer1.invoices.last.id).to eq(invoice3.id)
    end
  end
end
