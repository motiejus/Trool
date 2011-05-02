class Pot < ActiveRecord::Base
  has_many :pos
end

# Returns hash from which Pot can be populated
class PotInputParser
  def initialize(content)
    @content = content
  end

  def parse_copyright
    # Fourth line of the content
    raise "bad @content" unless @content
    line = @content.split("\n")[3]
    all, @author, @email, @year = line.match(/# (.*) <(.*)>, (\d+)/).to_a
    if not (@author and @email and @year):
      raise "Wrong Line: %s expected author, email, year." % line
    end
    @year = Integer(@year)
  end

  def parse_headers
  end

  def parse_messages
  end

  def all_dict
    { :author => @author, :email => @email, :year => @year }
  end
end
