class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.top_merchants_by_revenue(params[:quantity])
  end

  def show
    if params["date"]
      render json: Merchant.find(params[:id]).total_revenue_by_date(params["date"])
    else
      render json: Merchant.find(params[:id]).total_revenue
    end
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
