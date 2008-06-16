require 'test/unit'

require 'vying'

class OptimalBotTest < Test::Unit::TestCase

  def test_interface
    bot = OptimalBot.new

    assert( bot.respond_to?( :select ) )
    assert( bot.respond_to?( :offer_draw? ) )
    assert( bot.respond_to?( :accept_draw? ) )
    assert( bot.respond_to?( :resign? ) )
  end

end

