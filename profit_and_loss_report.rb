class ProfitAndLossReport

def initialize
  @accounts = Array.new
end

def add_account(account)
  @accounts << account
end

def render
  @accounts.each do |account|
    puts "Account: #{account.id} and #{account.description}"
    account.income.each do |key,value|
      puts "Month #{key} with value #{value}"
    end
    puts "Total is #{account.total}"
 end
end

end
