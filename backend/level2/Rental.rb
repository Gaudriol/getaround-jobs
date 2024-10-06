PRICE_DECREASE_AFTER_1_DAY = 0.9
PRICE_DECREASE_AFTER_4_DAYS = 0.7
PRICE_DECREASE_AFTER_10_DAYS = 0.5

class Rental
  attr_reader :id, :car_id, :start_date, :end_date, :distance

  def initialize(data)
    @id = data['id']
    @car_id = data['car_id']
    @start_date = Date.parse(data['start_date'])
    @end_date = Date.parse(data['end_date'])
    @distance = data['distance']
  end

  def get_duration()
    return (@end_date - @start_date).to_i + 1
  end

  def calculate_price(car)
    total_price = distance * car.price_per_km
    duration = get_duration()

    (1..duration).each do |day|
      case day
      when 1
        total_price += car.price_per_day
      when 2..4
        total_price += car.price_per_day * PRICE_DECREASE_AFTER_1_DAY
      when 5..10
        total_price += car.price_per_day * PRICE_DECREASE_AFTER_4_DAYS
      else
        total_price += car.price_per_day * PRICE_DECREASE_AFTER_10_DAYS
      end
    end

    return total_price.to_i()
  end
end
