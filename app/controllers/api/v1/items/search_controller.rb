class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.where(item_params)
  end

  def show
    render json: Item.where(item_params).first
  end

  private

    def item_params
      params.permit(:id, :name, :created_at, :updated_at, :description, :merchant_id, :unit_price)
    end

end
