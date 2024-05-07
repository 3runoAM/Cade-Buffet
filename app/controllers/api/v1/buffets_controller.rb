class Api::V1::BuffetsController < ActionController::API
  def index
    buffets = Buffet.all

    render status: 200, json: buffets.as_json(except: [:created_at, :updated_at, :crn, :user_id])
  end
end