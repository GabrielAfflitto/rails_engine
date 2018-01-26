require "rails_helper"

describe Customer, type: :model do

  describe "Associations" do
    it {is_expected.to respond_to(:invoices)}
    it {is_expected.to respond_to(:transactions)}
    it {is_expected.to respond_to(:merchants)}
  end

end
