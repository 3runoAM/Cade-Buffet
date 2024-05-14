class Api::V1::BuffetsController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ArgumentError, with: :render_412
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
    query_results = Buffet.where("LOWER(brand_name) LIKE ?", "%#{query.downcase}%")

    response.headers['Content-Type'] = 'application/json'

    return render_404 if query_results.empty?
    render status: 200, json: remove_created_and_updated(query_results)
  end

  def events
    buffet = Buffet.find(params[:id])
    render status: 200, json: buffet.events.as_json(include:{ event_prices: { except: [:created_at, :updated_at] }},
                                                    except: [:created_at, :updated_at])
  end

  def check_availability
    buffet = Buffet.find params[:buffet_id]
    event = buffet.events.find params[:event_id]
    event_date = Date.parse(params[:event_date])
    total_guests = params[:total_guests]

    puts "cheguei aqui"

    order = Order.new(buffet: buffet, event: event, event_date: event_date, total_guests: total_guests)
    order.event_date_cannot_be_in_the_past
    order.total_guests_must_be_within_event_limits
    puts order.has_same_day_order?

    response.headers['Content-Type'] = 'application/json'

    if order.errors.include?(:event_date) || order.errors.include?(:total_guests)
      return render status: 412, json: { error: order.errors.full_messages }
    elsif order.has_same_day_order?
      return render status: 200, json: {error: "Data indisponível"}
    end
    render status: 200, json: {price: order.set_price}
  end

  private

  def render_404
    render status: 404, json: {}
  end

  def render_412
    render status: 412, json: { error: "Data inválida" }
  end

  def remove_created_and_updated(buffet)
    buffet.as_json(except: [:created_at, :updated_at])
  end
end
