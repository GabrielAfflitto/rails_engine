class Api::V1::Merchants::RevenueDateController < ApplicationController

  def index
    render json: Invoice.all_revenue_for_date(params["date"])
  end

  private

    # def revenue_params
    #   params.permit(:id, :date)
    # end

end
