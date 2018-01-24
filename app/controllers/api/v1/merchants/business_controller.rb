class Api::V1::Merchants::BusinessController < ApplicationController


  def show
    Merchant.find(params[:id])
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
