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

    # Parse headers and return @lines with headers removed
    @headers, @lines = parse_headers
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
    @lines.each do |line|
      matched = false
      headertypes.each do |ht|
        if line.match(ht[0])
          puts "matched " + line + " to " + ht[0].to_s
          line = line[2..-1].strip
          params = (not ht[1].nil?) ? line.split(ht[1]) : line
          self.send ht[2], params
          matched = true
        end
      end

      # Stop looping
      break if not matched

      # Cut line
      @lines.shift
    end

    puts @lines

    return
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
    range = flags.select {|v| v =~ /^range:/}
    if range
      range_match = range.match /^range:\s(?<from>\w+)..(?<to>\w+)/
      @msg.range_from, @msg.range_to = range_match['from'], range_match['to']
      flags.delete range
    end

    # Handle all other flags
    flags.each do |flag|
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
