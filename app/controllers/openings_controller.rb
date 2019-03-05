# frozen_string_literal: true

class OpeningsController < ApplicationController
  before_action :must_be_logged_in!, only: %i[create]
  before_action :must_be_admin!, only: %i[create]

  def index
    page, per_page = pagination_params
    openings = Opening.paginate(page: page, per_page: per_page)
    render json: openings, meta: pagination_dict(openings)
  end

  def create
    opening = Opening.new(opening_params)
    opening.save

    if opening.valid?
      render json: opening
    else
      resource_invalid!(opening)
    end
  end

  private

  def opening_params
    params.require(:openings).permit(:title,
                                     :company,
                                     :location,
                                     :description,
                                     :qualifications,
                                     :start_date,
                                     :end_date).reverse_merge!(user_id: @current_user.id)
  end

  def pagination_params
    page             = params[:page] && params[:page][:number] || 1
    per_page         = params[:page] && params[:page][:size] || WillPaginate.per_page
    [page, per_page]
  end
end