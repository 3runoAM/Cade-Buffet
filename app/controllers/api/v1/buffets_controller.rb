class Api::V1::BuffetsController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  def index
    buffets = Buffet.all

    render status: 200, json: remove_created_and_updated(buffets)
  end

  def show
    buffet = Buffet.find params[:id]

    render status: 200, json: buffet.as_json(include: { address: { except: [:created_at, :updated_at] }},
                                             except: [:crn, :company_name, :created_at, :updated_at])
  end

  def search
    query = params[:query]
    query_results = Buffet.where("brand_name LIKE ?", "%#{query}%")

    response.headers['Content-Type'] = 'application/json'

    return render_404 if query_results.empty?
    render status: 200, json: remove_created_and_updated(query_results)
  end

  def events
    buffet = Buffet.find(params[:id])
    render status: 200, json: buffet.events.as_json(include:{ event_prices: { except: [:created_at, :updated_at] }},
                                                    except: [:created_at, :updated_at])
  end

  private

  def render_404
    render status: 404, json: {}
  end

  def remove_created_and_updated(buffet)
    buffet.as_json(except: [:created_at, :updated_at])
  end
end
