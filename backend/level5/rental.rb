require 'date'

require_relative 'services/price_calculator'
require_relative 'services/commission_calculator'
require_relative 'services/actions_generator'
require_relative 'services/options_balance_calculator'

class Rental
  attr_reader :id, :car, :options, :start_date, :end_date, :distance, :duration, :base_price, :commission

  def initialize(id:, car:, options:, start_date:, end_date:, distance:)
    raise 'Start date is after end date' if Date.parse(start_date) > Date.parse(end_date)
    @id = id
    @car = car
    @options = options
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @distance = distance
    @duration = get_duration
    @base_price = calculate_base_price
    @commission = calculate_commission_split
  end

  def get_duration
    (@end_date - @start_date).to_i + 1
  end

  def calculate_base_price
    PriceCalculator.new(car: @car, distance: @distance, duration: @duration).calculate
  end

  def calculate_commission_split
    CommissionCalculator.new(base_price: @base_price, duration: @duration).calculate
  end

  def generate_actions
    ActionsGenerator.new(rental: self).generate
  end
end
