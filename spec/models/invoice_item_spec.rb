require 'rails_helper'

describe InvoiceItem, type: :model do

  describe "Associations" do
    it {is_expected.to respond_to(:invoice)}
    it {is_expected.to respond_to(:item)}
  end

end
