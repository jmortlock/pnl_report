require 'date'

class ProfitAndLossReport
  attr_accessor :first_month

  def initialize
    @accounts = Array.new
    @first_month = 0;
  end

  private
  def get_month_name(index)
    return Date::MONTHNAMES[index]
  end

  public
  def add_account(account)
    @accounts << account
  end

  def render
    @accounts.each do |account|
      puts "Account: #{account.id} and #{account.description}"
      account.income.each do |key,value|
        month_name = get_month_name(key)
        puts "Month #{month_name} with value #{value}"
      end
      puts "Total is #{account.total}"
    end
  end

end
