require 'json'
require 'date'

require_relative 'car'
require_relative 'option'
require_relative 'rental'

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
    @options = data['options'].map do |option| 
      Option.new(id: option['id'], rental_id: option['rental_id'], type: option['type'])
    end
    @rentals = data['rentals'].map do |rental_data|
      id = rental_data['id']
      car = @cars.find { |c| c.id == rental_data['car_id'] }
      Rental.new(
        id: id,
        car: car,
        options: @options.select { |option| option.rental_id === id },
        start_date: rental_data['start_date'],
        end_date: rental_data['end_date'],
        distance: rental_data['distance']
      )
    end
  end

  def calculate_prices
    @rentals_with_price = @rentals.map do |rental|
      { id: rental.id, price: rental.base_price.to_i, commission: rental.commission }
    end
  end

  def generate_output
    @rentals.map do |rental|
      { id: rental.id, options: rental.options.map { |option| option.type }, actions: rental.generate_actions }
    end
  end

  def save_output(output_file)
    output = { rentals: generate_output }
    File.open(output_file, 'w') do |file|
      file.write(JSON.pretty_generate(output))
    end
  end
end

rental_service = Getaround.new
rental_service.load_data('data/input.json')
rental_service.save_output('data/output.json')
