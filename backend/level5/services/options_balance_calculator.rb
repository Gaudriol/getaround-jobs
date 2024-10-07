class OptionsBalanceCalculator
  def initialize(options:, duration:)
    @options = options
    @duration = duration
  end

  def calculate
    balance_owner = 0
    balance_drivy = 0

    @options.each do |option|
      price = option.calculate_option_price_for_duration(@duration)

      case option.type
      when 'gps', 'baby_seat'
        balance_owner += price
      when 'additional_insurance'
        balance_drivy += price
      end
    end
    {
      owner: balance_owner,
      drivy: balance_drivy
    }
  end
end