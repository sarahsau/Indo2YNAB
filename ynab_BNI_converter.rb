# BNI PDF Transactions to YNAB CSV Format Converter.
# Created by sarahsau (itsme@sarahsausan.com) in 2020; forked from kei178.
# run the script using ynab_BNI_converter.rb <BNIpdffile.pdf> <FilenameToExport.csv>.
# Import to YNAB using DD/MM/YYYY as the date format.

require 'pdf-reader'
require 'csv'

pdf_file = ARGV[0]

csv_file = ARGV[1]
if csv_file.to_s == ''
	csv_file = "BNI_converted_result.csv"
end

CSV.open(csv_file, "wb") do |csv|
  csv << ["Date", "Payee", "Memo", "Amount"]
end

File.open(pdf_file, 'rb') do |io|
  reader = PDF::Reader.new(io)
  pages = []

  # Parsing PDF
  reader.pages.each do |page|
    rows = []

    # Separating a whole text
    t = page.text.split("\n")

    t.each do |s|

      # Formatting - remove whitespace and empty cells
      ary = s.split("\s\s")
			ary.each(&:strip!)
			next if ary.empty?
      ary.delete_if { |str| str.nil? || str.empty? }

			# Remove "Kategori" column
			ary.delete_if { |str| str == "Tanpa Kategori"}

      rows << ary
    end

    pages << rows

  end

  # Formatting to YNAB CSV format.
    pages.each do |page|

      # Remove non-transactions.
      page.each do |rows| unless rows.include?('Db.') || rows.include?('Cr.')
        next
      end

      # Delete 'Kategori', 'Saldo', and 'Pecah Transaksi' columns.
			rows.delete(rows.last)
		 	rows.delete(rows.last)

      # Insert blank 'Payee' column.
      rows[4] = rows[3]
      rows[3] = rows[2]
      rows[2] = rows[1]
      rows[1] = ""

      # Make outflows negative.

      if rows[3].to_s.include?('Db.')
				amount = rows[4].delete(",").to_f
      	outflow = (0 - amount)
      	rows[4].replace(outflow.to_s)
			elsif rows[3].to_s.include?('Cr.')
				inflow = rows[4].delete(",").to_f
				rows[4].replace(inflow.to_s)
      end

      # Delete CR and DB.
      rows.delete(rows[3])

      # Format date column
      rows[0].gsub!('-Jan-', '/01/')
      rows[0].gsub!('-Feb-', '/02/')
      rows[0].gsub!('-Mar-', '/03/')
      rows[0].gsub!('-Apr-', '/04/')
      rows[0].gsub!('-May-', '/05/')
      rows[0].gsub!('-Jun-', '/06/')
      rows[0].gsub!('-Jul-', '/07/')
      rows[0].gsub!('-Aug-', '/08/')
      rows[0].gsub!('-Sep-', '/09/')
      rows[0].gsub!('-Oct-', '/10/')
      rows[0].gsub!('-Nov-', '/11/')
      rows[0].gsub!('-Dec-', '/12/')

			# Insert transactions into the resulting CSV file.
      CSV.open(csv_file, "a+") do |csv|
        csv << rows
      end

			# Giving user confirmation at the console.
			 p rows

    end
  end
end
