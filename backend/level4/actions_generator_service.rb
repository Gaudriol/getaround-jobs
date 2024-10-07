class ActionsGeneratorService
  def initialize(rental:)
    @rental = rental
  end

  def generate
    actions = []
    actions << { who: 'driver', type: 'debit', amount: @rental.total_price.to_i }
    # better way to get amount
    actions << { who: 'owner', type: 'credit', amount: (@rental.total_price * 0.7).to_i }
    actions << { who: 'insurance', type: 'credit', amount: @rental.commission[:insurance_fee].to_i }
    actions << { who: 'assistance', type: 'credit', amount: @rental.commission[:assistance_fee].to_i }
    actions << { who: 'drivy', type: 'credit', amount: @rental.commission[:drivy_fee].to_i }
    actions
  end
end