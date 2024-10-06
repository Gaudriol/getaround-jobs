require "json"
require "date"

require_relative "Rental"
require_relative "Car"

class Getaround
  attr_reader :cars, :rentals, :rentals_with_price

  def initialize()
    @cars = []
    @rentals = []
    @rentals_with_price = []
  end

  def load_data(input_file)
    data = JSON.parse(File.read(input_file))
    @cars = data['cars'].map do |car_data|
      Car.new(car_data)
    end
    @rentals = data['rentals'].map do |rental_data|
      Rental.new(rental_data)
    end
  end

  def calculate_prices()
    @rentals_with_price = @rentals.map do |rental|
      car = @cars.find do |c|
        c.id == rental.car_id
      end
      price = rental.calculate_price(car)
      { id: rental.id, price: price }
    end
  end

  def save_output(output_file)
    output = { rentals: @rentals_with_price }
    File.open(output_file, 'w') do |file|
      file.write(JSON.pretty_generate(output))
    end
  end
end

rental_service = Getaround.new()
rental_service.load_data('data/input.json')
rental_service.calculate_prices()
rental_service.save_output('data/output.json')
