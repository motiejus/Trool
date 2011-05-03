class Message < ActiveRecord::Base
  belongs_to :po
end

class MessageParser
  attr_reader :all_dict;
  attr_reader :msg

  def initialize(content)
    #require 'ruby-debug'
    #debugger
    linetypes = {
    }
    @lines = content.split(/\r\n|\n/).collect { |l| l.chomp }

    # Initialize a message object
    @msg = Message.new

    # Parse headers and return the number of headers parsed
    headcount = parse_headers

    # Parse messages
    @lines.shift(headcount)
    parse_body
  end

  # Parse messages
  # There are four kinds of messages: msgid, msgstr, msgctxt, msgid_plural
  # Each message can span across several lines until either a new message
  # kind starts, or the end of the block
  def parse_body
    mode = ""
    @lines.each do |line|
        # Each line is either a continuation of previous message
        # or starts a new message
        msgmatch = line.match /^(msg(?:id|str|ctxt|id_plural)) "(.*)"$/
        linematch = line.match /^"(.*)"$/
        if msgmatch
          mode = msgmatch[1]
          @msg.send mode + "=", msgmatch[2]
        elsif linematch
          @msg.send(mode + "=", @msg.send(mode) + linematch[1])
        end
    end
  end

  # Parse headers of a single message
  def parse_headers
    headertypes = [
      # Start, content, processor
      [/^#\./, nil, 'header_extracted'],
      [/^#:/, nil, 'header_reference'],
      [/^#,/, ',', 'header_flags'],
      [/^#\|/, nil, 'header_next'],
      [/^# /, nil, 'header_comment'],
    ]

    # Number of headers
    numheads = 0

    @lines.each do |line|
      matched = false
      headertypes.each do |ht|
        if line.match(ht[0])
          line = line[2..-1].strip
          params = (not ht[1].nil?) ? line.split(ht[1]) : line
          self.send ht[2], params
          matched = true
          break
        end
      end

      # Stop looping
      break if not matched

      # Increase number of headers found
      numheads += 1
    end

    return numheads
  end

  def header_comment(comment)
    @msg.translator_comments = comment
  end

  def header_extracted(comment)
    @msg.extracted_comments = comment
  end

  def header_flags(flags)
    flags.map! {|f| f.strip}

    # Handle range flag separately
    range = flags.select {|v| v =~ /^range:/}[0]
    if range
      range_match = range.match /^range:\s(?<from>\w+)..(?<to>\w+)/
      @msg.range_from, @msg.range_to = range_match['from'], range_match['to']
      flags.delete range
    end

    # Handle all other flags
    flags.each do |flag|
      flag.gsub!("-", "_")
      @msg.send flag + "=", true
    end
  end

  def header_reference(reference)
    @msg.reference = reference
  end

  def header_next(nxt)
    # TODO
    puts nxt
  end
end
