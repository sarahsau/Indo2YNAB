require_relative 'lib/bca'
require_relative 'lib/bni'

# conversion
bank = ARGV[0]
file = ARGV[1]

case bank
when /bca/i
	statement = BankCentralAsia.new(file, ARGV[2], ARGV[3])

	statement.output_file
	statement.bca_processing
	statement.assign_payee

when /bni/i
	statement = BankNegaraIndonesia.new(file, ARGV[2])

	statement.output_file
	statement.bni_processing
	statement.assign_payee
end
