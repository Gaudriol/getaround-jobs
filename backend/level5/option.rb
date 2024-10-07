class Option
  attr_reader :id, :rental_id, :type

  OPTION_PRICES_PER_DAY = {
    'gps': 500,
    'baby_seat': 200,
    'additional_insurance': 1000,
  }

  def initialize(id:, rental_id:, type:)
    @id = id
    @rental_id = rental_id
    @type = type
  end

  def calculate_option_price_for_duration(duration)
    OPTION_PRICES_PER_DAY[@type.to_sym] * duration
  end
end