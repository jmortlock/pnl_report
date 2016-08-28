require_relative 'profit_and_loss_report'
#
# Adds the income for each report to one another.
#
class ReportSummer
  def initialize
    @accounts = Array.new
  end

  def build_report(report_number, report)
    report.accounts.each do |account|
      mergedAccount = @accounts.select { |x| x.id == account.id }.first
      if mergedAccount.nil?
        mergedAccount = Account.new id:account.id, description:account.description
      end

      for i in 0..11 do
        income = mergedAccount.get_month_income(0, i);
        mergedAccount.set_month_income(0, i, income + account.get_month_income(0, i))
      end
      @accounts << mergedAccount
    end
  end

  def sum(reports)
      result = ProfitAndLossReport.new
      index = 0
      reports.each do |report|
        build_report(index, report)
        index = index + 1
      end

      @accounts.each do |account|
        result.add_account(account)
      end
      return result
  end
end
