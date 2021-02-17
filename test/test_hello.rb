require_relative 'test_helper'
require_relative '../hello'

class TestHello < MiniTest::Test
  def setup
    @friendly_greeting = Greeting.new
  end

  def test_hello
    assert_equal "hello", @friendly_greeting.hello
  end
end
