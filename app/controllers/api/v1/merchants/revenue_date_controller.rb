class Api::V1::Merchants::RevenueDateController < ApplicationController

  def index
    render json: {total_revenue: Merchant.all_revenue_for_date(params["date"])}
    # refactored method
  end

end
