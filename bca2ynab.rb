# BCA Transactions CSV to YNAB Converter

require 'csv'

# arguments for script run

class BcaIndoYnab
	attr_accessor :input, :year, :output

	def initialize(input, year, output)
		@input = input
		@year = year
		@output = output || 'bca_result.csv'
	end

	def output_file
		CSV.open(self.output, "wb") do |csv|
			csv << ["Date", "Payee", "Memo", "Amount"]
		end
	end

	def bca_processing
		CSV.foreach(self.input, skip_lines:/Balance/, skip_blanks: true) do |row|

			# Ignore four beginning and ending rows and also pending transactions.
			date = row[0].to_s
			if date.include?('PEND') || date.include?('Name') || date.include?('Balance') || date.include?('Currency') || date.include?('Account') || date.include?('Credit') || date.include?('Debet')
				next
			end

			# Format date in the first column, assuming that all transactions occur in the same year.

			annoying_first_character = date.chr
			date.delete!(annoying_first_character)
			date_with_year = date.dup.insert(-1, '/' + self.year)

			unless date_with_year == "/#{self.year}"
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
			CSV.open(self.output, "a+") do |csv|
				csv << row
			end

			# Show result in the console.
			p row
		end
	end
end

bca = BcaIndoYnab.new(ARGV[0], ARGV[1], ARGV[2])

bca.output_file
bca.bca_processing
