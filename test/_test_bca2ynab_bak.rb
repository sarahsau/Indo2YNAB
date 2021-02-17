require 'rake/testtask'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use!

Rake::TestTask.new do |t|
  t.test_files = FileList['test/test*.rb']
end

# to use in testing
require_relative '../bca2ynab'
require_relative 'sampleBCA'
require 'csv'

class TestIndoYnab < MiniTest::Test
  attr_accessor :result

  def setup
  end

#  @result = CSV.read('BCA_result.csv')

  def test_result_should_exist
    assert exist?("result.csv")
  end

  def test_result_should_contain_correct_column
    first_column = result[0]
    assert first_column.include?("Date")
    assert first_column.include?("Payee")
    assert first_column.include?("Memo")
    assert first_column.include?("Amount")
    assert_equal 4, first_column.flatten.count
  end

  def test_result_date_column_hygiene
    CSV.foreach('bca_result.csv', skip_blanks: true) do |row|
      refute_includes row[0], /pend/i
      refute_includes row[0], /name/i
      refute_includes row[0], /currency/i
      refute_includes row[0], /account/i
      refute_includes row[0], /credit/i
      refute_includes row[0], /debet/i
    end
  end
end
