require 'date'

require_relative 'price_calculator_service'
require_relative 'commission_calculator_service'
require_relative 'actions_generator_service'

class Rental
  attr_reader :id, :car, :start_date, :end_date, :distance, :duration, :total_price, :commission

  PRICE_DECREASE_AFTER_1_DAY = 0.9
  PRICE_DECREASE_AFTER_4_DAYS = 0.7
  PRICE_DECREASE_AFTER_10_DAYS = 0.5

  def initialize(id:, car:, start_date:, end_date:, distance:)
    @id = id
    @car = car
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @distance = distance
    @duration = get_duration
    @total_price = calculate_total_price
    @commission = calculate_commission_split
  end

  def get_duration
    (@end_date - @start_date).to_i + 1
  end

  def calculate_total_price
    PriceCalculatorService.new(car: @car, distance: @distance, duration: @duration).calculate
  end

  def calculate_commission_split
    CommissionCalculatorService.new(total_price: @total_price, duration: @duration).calculate
  end

  def generate_actions
    ActionsGeneratorService.new(rental: self).generate
  end
end
