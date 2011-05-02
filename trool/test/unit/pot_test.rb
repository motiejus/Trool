require 'test_helper'

require 'rubygems'
require 'ruby-debug'
Debugger.start

class PotTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @content = File.open('git.pot', 'r').read
  end

  test "load content" do
    assert @content
  end

  test "get author, email and year" do
    parser = PotInputParser.new @content
    parser.parse_copyright
    ret = parser.all_dict
    assert_equal "Couch Dwellers", ret[:first_author]
    assert_equal "couch@toostis.com", ret[:first_author_email]
    assert_equal 2011, ret[:first_author_year]
  end
end
