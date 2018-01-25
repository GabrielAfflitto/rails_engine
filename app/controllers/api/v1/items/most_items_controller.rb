class Api::V1::Items::MostItemsController < ApplicationController

  def index
    render json: Item.top_item_by_number_sold(params[:quantity])
  end
end
