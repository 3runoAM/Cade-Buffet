class Api::V1::BuffetsController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  def index
    buffets = Buffet.all

    render status: 200, json: buffets.as_json(except: [:created_at, :updated_at])
  end

  def search
    query = params[:query]
    query_results = Buffet.where("brand_name LIKE ?", "%#{query}%")

    response.headers['Content-Type'] = 'application/json'
    render status: 200, json: query_results.as_json(except: [:created_at, :updated_at])
  end

  def events
    buffet = Buffet.find(params[:id])
    render status: 200, json: buffet.events.as_json(include: { event_prices: { except: [:created_at, :updated_at] } },
                                                    except: [:created_at, :updated_at])
  end

  private

  def render_404
    render status: 404, json: {}
  end
end
