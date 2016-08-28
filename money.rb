class Money
  DEFAULT_EXCHANGE_RATE = 1.0
  attr_accessor :amount, :exchange_rate

  def initialize(amount, exchange_rate)
    amount ||= 0
    exchange_rate ||= DEFAULT_EXCHANGE_RATE
    @amount = amount
    @exchange_rate = exchange_rate
  end

  def exchange_amount
    return @amount * @exchange_rate
  end

  def +(money)
    return Money.new(self.exchange_amount + money.exchange_amount, DEFAULT_EXCHANGE_RATE)
  end
end
