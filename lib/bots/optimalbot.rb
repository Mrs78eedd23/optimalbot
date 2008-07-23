
require 'vying'

class OptimalBot < Bot

  def initialize( username=nil, id=nil )
    id ||= 101

    super( username, id )
  end

end

