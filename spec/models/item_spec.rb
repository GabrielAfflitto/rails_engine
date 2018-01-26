require 'rails_helper'

describe Item, type: :model do

  describe "Associations" do
    it {is_expected.to respond_to(:merchant)}
    it {is_expected.to respond_to(:invoice_items)}
    it {is_expected.to respond_to(:invoices)}
  end

end
