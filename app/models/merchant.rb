class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def revenue
    binding.pry
  end
end
