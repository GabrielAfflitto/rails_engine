require 'rails_helper'

describe Invoice, type: :model do

  describe "Associations" do
    it {is_expected.to respond_to(:transactions)}
    it {is_expected.to respond_to(:invoice_items)}
    it {is_expected.to respond_to(:items)}
    it {is_expected.to respond_to(:customer)}
    it {is_expected.to respond_to(:merchant)}
  end

end
