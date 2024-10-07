class CommissionCalculator
  COMMISSION_PERCENTAGE = 0.3
  INSURANCE_FEE_PERCENTAGE = 0.5
  ASSISTANCE_FEE_IN_CENTS_PER_DAY = 100

  def initialize(base_price:, duration:)
    raise 'Duration is not positive' if duration <= 0

    @base_price = base_price
    @duration = duration
  end

  def calculate
    commission = @base_price * COMMISSION_PERCENTAGE
    insurance_fee = commission * INSURANCE_FEE_PERCENTAGE
    assistance_fee = @duration * ASSISTANCE_FEE_IN_CENTS_PER_DAY
    drivy_fee = commission - insurance_fee - assistance_fee

    raise 'Drivy fee is negative' if drivy_fee < 0

    {
      insurance_fee: insurance_fee.to_i,
      assistance_fee: assistance_fee.to_i,
      drivy_fee: drivy_fee.to_i
    }
  end
end