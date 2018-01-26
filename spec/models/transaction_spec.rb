require 'rails_helper'

describe Merchant, type: :model do
  describe "Associations" do
    it {is_expected.to respond_to(:invoices)}
  end
end
