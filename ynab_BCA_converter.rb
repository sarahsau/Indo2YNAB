# BCA Transactions CSV to YNAB Converter.
# Created by sarahsau (itsme@sarahsausan.com) in 2020; Forked from wesmcouch (wesmcouch@gmail.com).
# run the script using ynab_BCA_converter.rb <exportedTransactions.csv> <FilenameToExport> <statement year>.
# Import to YNAB using DD/MM/YYYY as the date format.

require 'csv'
file_name = ARGV[0]

new_file_name = ARGV[1]
if new_file_name.to_s == ''
	new_file_name = "converted_result.csv"
end

statement_year = ARGV[2].to_s

CSV.open(new_file_name, "wb") do |csv|
	csv << ["Date", "Payee", "Memo", "Amount"]
end

CSV.foreach(file_name, skip_lines:/Balance/, skip_blanks: true) do |row|

	# Ignore four beginning and ending rows and also pending transactions.
	date = row[0].to_s
	if date.include?('PEND') || date.include?('Name') || date.include?('Balance') || date.include?('Currency') || date.include?('Account') || date.include?('Credit') || date.include?('Debet')
		next
	end

	# Format date in the first column, assuming that all transactions occur in the same year.

	annoying_first_character = date.chr
	date.delete!(annoying_first_character)
	date_with_year = date.dup.insert(-1, '/' + statement_year)

	unless date_with_year == "/#{statement_year}"
		row[0] = date_with_year
	end

	# Delete 'branch' and 'running balance' columns.
	 row.delete(row[2])
	 row.delete(row[4])

	# assign credit and debit to transactions
	if row[3].to_s.include?('DB')
		outflow = 0 - row[2].to_f
		row[2].replace(outflow.to_s)
	end

	# Delete CR and DB.
	row.delete(row[3])

	# Move columns to the correct headers.
	row[3] = row[2]
	row[2] = row[1]
	row[1] = ""

	# Assign common payees.
	memo_column = row[2].to_s
	payee_column = row[1].to_s

	if memo_column.include?('SHOPEEPAY')
		payee_column << "ShopeePay"
	elsif memo_column.include?('TOKOPEDIA')
		payee_column << "Tokopedia"
	elsif memo_column.include?('OVO')
		payee_column << "OVO"
	elsif memo_column.include?('SAYURBOX')
		payee_column << "Sayurbox"
	elsif memo_column.include?('GO-PAY')
		payee_column << "Gopay"
	elsif memo_column.include?('FAVE')
		payee_column << "Fave"
	elsif memo_column.include?('BUNGA') || memo_column.include?('PAJAK BUNGA') || memo_column.include?('BIAYA ADM')
		payee_column << "BCA"
	end

# Insert results to the new file.
	CSV.open(new_file_name, "a+") do |csv|
		csv << row
	end

	# Show result in the console.
	puts row.inspect
end
