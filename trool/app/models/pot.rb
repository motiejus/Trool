require 'date'
require 'message'

class Pot < ActiveRecord::Base
  has_many :pos

  # User uploads a new pot file
  # TODO marking as deprecated
  def update_data(filedata)
    parser = PotInputParser.new filedata
    data = parser.parse_meta
    data[:filedata] = filedata

    # Update meta information
    self.update_attributes(data)

    # Update all related po files
    self.pos.each do |po|
      oldmsgs = po.messages.clone
      uplmsgs = parser.parse_messages

      # Create messages that are in uplmsgs but not in oldmsgs
      oldids = oldmsgs.map {|msg| msg.msgid}
      uplmsgs.each do |msg|
        if not oldids.include? msg.msgid
          # New message - create db entry
          po.messages.push uplmsgs
        end
      end

      # Messages to be marked for deletion in next round
      uplids = uplmsgs.map {|msg| msg.msgid}
      oldmsgs.each do |msg|
        if not uplmsgs.include? msg.msgid
          # Message not in uploaded file - mark for removal
          # TODO mark as deprecated
          po.messages.delete msg
        end
      end

      return self.save

      # TODO if a phrase has a msgid which is only slightly
      # different from some msgid in db and msgstr is empty -- copy
      # msgstr and mark as fuzzy
      # e.g. require 'text'; Text::Levenshtein.distance('a', 'a')

      # TODO if a phrase has a different non-empty msgstr
      # in the uploaded file -- mark for merge [OR simply add new
      # version as default when versioning is implemented]
      # NOTE we only need this if we allow uploading PO files (do we?)
    end
  end
end

# Returns hash from which Pot can be populated
class PotInputParser
  attr_reader :all_dict;

  def initialize(content)
    @pot = content
    @all_dict = {}
  end

  # Parse pot information
  # Messages should only be parsed when we create po objects
  def parse_meta
    parse_copyright
    parse_headers
    return @all_dict
  end

  def parse_copyright
    # Fourth line of the content
    raise "Empty @pot, please check if you properly constructed" unless @pot
    line1, line2, line3, line4 = @pot.split("\n").collect { |l| l.chomp }[0..3]
    x, first_author, first_author_email, first_author_year =\
        line4.match(/# (.*) <(.*)>, (\d+)/).to_a
    name = line3.match(/distributed under the same license as the (.*) package./)[1]
    if not (first_author and first_author_email and first_author_year)
      raise "Wrong Line: %s expected author, email, year." % line4
    end
    @all_dict[:title] = line1.sub(/^# /, '')
    @all_dict[:name] = name
    @all_dict[:first_author] = first_author
    @all_dict[:first_author_email] = first_author_email
    @all_dict[:first_author_year] = Integer(first_author_year)
  end

  def parse_headers
    fetchable = {
        :project_id_version => "Project-Id-Version: (.*)\\\\n",
        :report_msgid_bugs_to => "Report-Msgid-Bugs-To: (.*)\\\\n",
        :pot_creation_date => "POT-Creation-Date: (.*)\\\\n",
        :last_translator => "Last-Translator: (.*)\\\\n",
        :language_team => "Language-Team: (.*)\\\\n",
        #:mime_version => "MIME-Version: (.*)\\\\n",
        :content_type => "Content-Type: (.*)\\\\n",
        :content_transfer_encoding => "Content-Transfer-Encoding: (.*)\\\\n",
    }
    fetchable.each { |k,re| 
        val = @pot.match(re)[1]
        raise "Wrong %s: %s" % [k.replace(/: .*/, ''), val] unless val
        @all_dict[k] = val
    }
    @all_dict[:pot_creation_date] = DateTime.parse(
        @all_dict[:pot_creation_date])
  end

  def parse_messages
      re = /(?:\r\n|\n){2,}/
      messages = @pot.split(re)
      raise "messages empty" unless messages

      messages.reject!{ |item| item.blank? }
      messages = messages[1..-1]
      @all_dict[:msg] = []
      raise "messages empty" unless messages
      messages.each do |msg|
        parser = MessageParser.new msg 
        @all_dict[:msg].push parser.msg
      end
      return @all_dict[:msg]
  end
end
