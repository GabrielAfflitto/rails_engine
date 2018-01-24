class ItemSerializer < ActiveModel::Serializer
  attributes :id, :description, :merchant_id, :name, :unit_price

  def unit_price
    (object.unit_price / 100.0).to_s
  end
end
