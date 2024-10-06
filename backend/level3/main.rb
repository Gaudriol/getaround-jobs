require "json"
require "date"

require_relative "rental"
require_relative "car"

class Getaround
  attr_reader :cars, :rentals, :rentals_with_price

  def initialize
    @cars = []
    @rentals = []
    @rentals_with_price = []
  end

  def load_data(input_file)
    data = JSON.parse(File.read(input_file))
    @cars = data['cars'].map do |car_data|
      Car.new(
        id: car_data['id'],
        price_per_day: car_data['price_per_day'],
        price_per_km: car_data['price_per_km']
      )
    end
    @rentals = data['rentals'].map do |rental_data|
      car = @cars.find { |c| c.id == rental_data['car_id'] }
      Rental.new(
        id: rental_data['id'],
        car: car,
        start_date: rental_data['start_date'],
        end_date: rental_data['end_date'],
        distance: rental_data['distance']
      )
    end
  end

  def calculate_prices
    @rentals_with_price = @rentals.map do |rental|
      { id: rental.id, price: rental.total_price.to_i, commission: rental.commission }
    end
  end

  def save_output(output_file)
    output = { rentals: @rentals_with_price }
    File.open(output_file, 'w') do |file|
      file.write(JSON.pretty_generate(output))
    end
  end
end

rental_service = Getaround.new
rental_service.load_data('data/input.json')
rental_service.calculate_prices
rental_service.save_output('data/output.json')
