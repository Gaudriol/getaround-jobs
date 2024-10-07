class PriceCalculatorService
  PRICE_DECREASE_AFTER_1_DAY = 0.9
  PRICE_DECREASE_AFTER_4_DAYS = 0.7
  PRICE_DECREASE_AFTER_10_DAYS = 0.5

  def initialize(car:, distance:, duration:)
    @car = car
    @distance = distance
    @duration = duration
  end

  def calculate
    total_price = @distance * @car.price_per_km

    (1..@duration).each do |day|
      case day
      when 1
        total_price += @car.price_per_day
      when 2..4
        total_price += @car.price_per_day * PRICE_DECREASE_AFTER_1_DAY
      when 5..10
        total_price += @car.price_per_day * PRICE_DECREASE_AFTER_4_DAYS
      else
        total_price += @car.price_per_day * PRICE_DECREASE_AFTER_10_DAYS
      end
    end

    total_price
  end
end