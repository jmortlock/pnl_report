require_relative 'report_csv_importer'
require_relative 'report_comparator'

importer = ReportCSVImporter.new
reports = Array.new

reports << importer.import("test.csv")
#report.render

reports << importer.import("test.csv")
#second_report.render

comparator = ReportComparator.new
comparator.compare(reports)

puts "The end"
