require_relative 'report_csv_importer'

importer = ReportCSVImporter.new
report = importer.import("test.csv");
report.render

puts "The end"
