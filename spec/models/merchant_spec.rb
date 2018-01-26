require "rails_helper"

describe Merchant, type: :model do

  describe "Instance Methods" do
    it "sums revenue for merchant" do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant: merchant)
      invoice_items = create(:invoice_item, invoice: invoice)
      transaction = create(:transaction, invoice: invoice)
      transaction2 = create(:transaction, invoice: invoice)
      transaction3 = create(:transaction, invoice: invoice)

      expect(merchant.total_revenue).to eq({:revenue=>"40.5"})
    end
  end

  describe "Associations" do
    it {is_expected.to respond_to(:invoices)}
    it {is_expected.to respond_to(:items)}
    it {is_expected.to respond_to(:transactions)}
    it {is_expected.to respond_to(:customers)}
  end

end
