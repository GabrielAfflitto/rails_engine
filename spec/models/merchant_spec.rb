require "rails_helper"

describe Merchant, type: :model do

  describe "Class Methods" do
    it "sums revenue for merchant" do
      merchant = create(:merchant)
      create(:item, merchant: merchant)
      create(:item, merchant: merchant)
      create(:item, merchant: merchant)
      create(:item, merchant: merchant)

      expect(merchant.revenue).to eq(merchant.items.unit_price.sum)
    end
  end

end
