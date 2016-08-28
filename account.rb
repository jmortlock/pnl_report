require_relative 'money'

class Account
  attr_accessor :id, :description

  def initialize (id:0, description:"")
    @container = Array.new
    @id = id
    @description = description
  end

  #
  # Set the income for a given month.
  #
  def set_month_income(index, month, amount)
    raise "Month #{month} is outside of range" unless month >= 0 && month <= 11
    unless amount.nil?
      income = @container[index]
      #create a new entry for the month if it dosen't exist.
      if income.nil?
        income = Hash.new
        @container[index] = income
      end
      income[month] = amount
    end
  end

  def get_month_income(index, month)
      income_table = @container[index]
      if !income_table.nil? && !income_table[month].nil?
        return income_table[month]
      end
      return Money.new(0,0)
  end

  def income_table
    return @container
  end

  def income(index)
    return @container[index]
  end

  def total(index)
    total = 0
    income = income(index)
    unless income.nil?
      income.each do |key, value|
        total += value
      end
    end
    return total
  end
end
