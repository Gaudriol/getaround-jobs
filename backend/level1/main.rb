require "json"
require "date"

class Car
  def initialize(data)
    @id = data['id']
    @price_per_day = data['price_per_day']
    @price_per_km = data['price_per_km']
  end
end

class Rental
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
    return get_duration() * car.price_per_day + distance * car.price_per_km
  end
end

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
      # Impossible de faire return explicit ?
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
