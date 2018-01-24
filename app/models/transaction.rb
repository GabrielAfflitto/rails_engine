class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful, -> {where(result: '0')}
  scope :not_successful, -> {where(result: '1')}

  default_scope {order(:id)}
end
