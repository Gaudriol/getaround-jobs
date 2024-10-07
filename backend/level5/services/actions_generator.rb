require_relative 'options_balance_calculator'

class ActionsGenerator
  def initialize(rental:)
    @rental = rental
    @options_balance = OptionsBalanceCalculator.new(options: @rental.options, duration: @rental.duration).calculate
  end

  def generate
    [
      action('driver', 'debit', driver_debit),
      action('owner', 'credit', owner_credit),
      action('insurance', 'credit', @rental.commission[:insurance_fee].to_i),
      action('assistance', 'credit', @rental.commission[:assistance_fee].to_i),
      action('drivy', 'credit', drivy_credit)
    ]
  end

  def driver_debit
    @rental.base_price + @options_balance[:owner] + @options_balance[:drivy]
  end

  def owner_credit
    (@rental.base_price * 0.7).to_i + @options_balance[:owner]
  end

  def drivy_credit
    @rental.commission[:drivy_fee].to_i + @options_balance[:drivy]
  end

  def action(who, type, amount)
    { who: who, type: type, amount: amount.to_i }
  end
end
