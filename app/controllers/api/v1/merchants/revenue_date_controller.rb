class Api::V1::Merchants::RevenueDateController < ApplicationController

  def index
    render json: Merchant.all_revenue_for_date(params["date"])
  end

end
