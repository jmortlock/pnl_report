require 'csv'
require 'date'
require_relative 'account'
require_relative 'profit_and_loss_report'

report = ProfitAndLossReport.new
accounts = Array.new
CSV.foreach('test.csv', converters: :numeric) do |row|
  if row.size > 7
      unless row[0].nil?
        account = Account.new();
        account.id = row[0].strip
        account.description = row[1].strip
        for i in 2..row.size-2
          account.set_month_income(i-2, row[i])
        end
        report.add_account(account)
      end
  end
end

report.render
puts "The end"
