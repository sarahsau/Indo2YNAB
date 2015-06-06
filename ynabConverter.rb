# Purdue Federal Transactions CSV to YNAB Converter
# Wesley Couch 2015 - wesmcouch@gmail.com
# run the script using ynabConverter.rb <exportedTransactions.csv> <FilenameToExport>

require 'csv'
fileName = ARGV[0]
firstRun = true

newFileName = ARGV[1]
if newFileName.to_s == ''
	newFileName = convertedYNABfile
end

CSV.open(newFileName, "wb") do |csv|
	csv << ["Date", "Payee", "Category", "Memo", "Outflow", "Inflow"]
end

CSV.foreach(fileName) do |row|
	if firstRun == true
		firstRun = false
		next
	end


	if row[1].include? '(Pending)' # Do not include pending transactions in the import
		next
	end
	
	if row[4][0].chr == '(' # Move outflows and inflows to proper columns
		datLength = row[4].length
		datLength = datLength - 2
		row[4] = row[4][1, datLength]
		row[5] = ""
	else
		row[5] = row[4]
		row[4] = ""
	end
	CSV.open(newFileName, "a+") do |csv|
		csv << row
	end
	
	puts row.inspect # output row
end
