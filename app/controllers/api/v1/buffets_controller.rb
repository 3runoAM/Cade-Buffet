class Api::V1::BuffetsController < ActionController::API
  def index
    buffets = Buffet.all

    render status: 200, json: buffets.as_json(except: [:id, :created_at, :updated_at, :crn, :user_id])
  end

  def search
    query = params[:query]
    query_results = Buffet.where("brand_name LIKE ?", "%#{query}%")

    # response.header.delete('charset=utf-8')
    render status: 200, json: query_results.as_json(except: [:id, :created_at, :updated_at, :crn, :user_id])
  end
end