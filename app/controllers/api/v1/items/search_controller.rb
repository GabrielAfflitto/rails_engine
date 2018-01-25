class Api::V1::Items::SearchController < ApplicationController

  def index
    render json: Item.where(item_params)
  end

  def show
    render json: Item.find_by(item_params)
  end

  private

    def item_params
      formatted_item_params(params.permit(:id, :name, :created_at, :updated_at, :description, :unit_price, :merchant_id))
    end

    def formatted_item_params(params)
      if params[:unit_price]
        params[:unit_price] = params[:unit_price].gsub(".", "")
      end
      params
    end


end
