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
    all, @first_author, @first_author_email, @first_author_year =\
        line.match(/# (.*) <(.*)>, (\d+)/).to_a
    if not (@first_author and @first_author_email and @first_author_year):
      raise "Wrong Line: %s expected author, email, year." % line
    end
    @first_author_year = Integer(@first_author_year)
  end

  def parse_headers
  end

  def parse_messages
  end

  def all_dict
    { :first_author => @first_author,
        :first_author_email => @first_author_email,
        :first_author_year => @first_author_year
    }
  end
end
