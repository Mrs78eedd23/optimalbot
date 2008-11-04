# Copyright 2007, Eric Idema except where otherwise noted.
# You may redistribute / modify this file under the same terms as Ruby.

require 'vying'
require 'rubygems'



begin
  require 'sqlite3'
  SQLite = SQLite3
  DB_FILE = /footsteps3\.db$/  unless Object.const_defined?( :DB_FILE )
rescue Exception
  begin
    require 'sqlite'
    DB_FILE = /footsteps.db$/  unless Object.const_defined?( :DB_FILE )
  rescue Exception
    puts "WARNING: Failed to load OptimalBot, SQLite support is missing"
  end
end

if Object.const_defined?( :SQLite ) &&
   ! Object.nested_const_defined?( "OptimalBot::Footsteps" )

  class OptimalBot < Bot
    class Footsteps < Bot

      difficulty :hard

      $:.each do |d|
        Dir.glob( "#{d}/**/bots/optimalbot/*" ) do |f|
          if f =~ DB_FILE
            FOOTSTEPS_DB = f unless defined? FOOTSTEPS_DB
          end
        end
      end

      def select( sequence, position, player )
        opp = player == :left ? :right : :left
        marker = position.board.occupied( :white ).first
  
        dist = player == :left ? marker.x : 6 - marker.x
        r = rand
  
        db = SQLite::Database.new( FOOTSTEPS_DB )
  
        b = db.get_first_value( "select bid from footsteps " +
                                "  where points_a = ? " +
                                "    and points_b = ? " +
                                "    and distance_a = ? " +
                                "    and prob_min <= ? " +
                                "    and prob_max > ? ", 
                                position.points[player],
                                position.points[opp],
                                dist,
                                r, r )
 
        if position.rules.version == "1.0.0"
          "#{player}_#{b.nil? ? 1 : b}"
        else 
          "#{b.nil? ? 1 : b}"
        end
      end
    end
  end

end

