class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    render json: InvoiceItem.where(invoice_item_params)
  end

  def show
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  private

    def invoice_item_params
      params.permit(:id, :created_at, :updated_at, :unit_price, :item_id, :invoice_id, :quantity)
    end

end
