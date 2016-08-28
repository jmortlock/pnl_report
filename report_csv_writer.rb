require 'csv'
require 'date'
require_relative 'account'
require_relative 'profit_and_loss_report'

class ReportCSVWriter
  private
    def write_account_to_csv(csv, account)
      line = Array.new
      line << account.id
      line << account.description
      for i in 0..11
        line << account.get_month_income(0, i);
      end
      csv << line
    end

  public
    def write_to_file(filename, report)
      CSV.open(filename, "wb") do |csv|
        report.accounts.each do |account|
          write_account_to_csv(csv, account)
        end
      end
    end
end
