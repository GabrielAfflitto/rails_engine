require 'rails_helper'

describe "Invoices" do
  it "sends a list of invoices" do
    create_list(:invoice, 5)

    get '/api/v1/invoices'

    expect(response).to be_successful

    items = JSON.parse(response.body)
    
    expect(items.count).to eq(5)
  end
end
