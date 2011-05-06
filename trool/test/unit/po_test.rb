require 'test_helper'
require Rails.root.to_s + '/app/models/pot'
require Rails.root.to_s + '/app/models/po'

class PoTest < ActiveSupport::TestCase
  def setup
    content = File.open(Rails.root.to_s+'/test/git.pot', 'r').read
    parser = PotInputParser.new content
    pot = Pot.new({ :filedata => content }.merge parser.parse_meta)
    @po = Po.new
    @po.pot = pot
    @po.populate_from_pot
  end

  test "generate string" do
    assert_equal "#: wt-status.c:134", @po.messages.first.header_string
    assert_equal "msgid \"Unmerged paths:\"\nmsgstr \"\"",
        @po.messages.first.body_string
    assert_equal "#: wt-status.c:142 wt-status.c:159\n" +
                 "#, fuzzy, c_format, range: 3..23",
        @po.messages[2].header_string
    assert_equal "#: wt-status.c:134\nmsgid \"Unmerged paths:\""+
                 "\nmsgstr \"\"",
        @po.messages.first.to_string
  end
end
