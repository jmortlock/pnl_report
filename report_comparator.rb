class ReportComparator

  def initialize
    @accounts = Array.new
  end

  def build_report(report_number, report)
    report.accounts.each do |account|
      mergedAccount = @accounts.bsearch { |x| x.id == account.id }
      if (mergedAccount.nil?)
        mergedAccount = Account.new id:account.id, description:account.description
      end
      
      for i in 0..11 do
        mergedAccount.set_month_income(report_number, i, account.get_month_income(0, i))
      end
      @accounts << mergedAccount
    end
  end

  def compare(reports)
      result = ProfitAndLossReport.new
      index = 0
      reports.each do |report|
        build_report(index, report)
        index = index + 1
      end

      @accounts.each do |account|
        result.add_account(account)
      end
      result.render
  end
end
