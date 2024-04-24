class Client::BuffetsController < ApplicationController
  def search
    query = params[:query]
    records_by_attributes = Buffet.where("brand_name LIKE :query OR company_name LIKE :query OR crn LIKE :query
                                         OR description LIKE :query", query: "%#{query}%")

    records_by_event = Buffet.joins(:events).where("events.name LIKE :query OR events.description LIKE :query",
                                                   query: "%#{query}%")

    @buffets = (records_by_attributes + records_by_event).uniq
    @buffets.sort_by { |buffet| buffet.brand_name }

    render partial: 'shared/unauthenticathed_user_buffet_form', locals: { buffets: @buffets }
  end
end