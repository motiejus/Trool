class Message < ActiveRecord::Base

  FLAGS = [:fuzzy, :range, :c_format, :objc_format, :sh_format,
           :python_format, :lisp_format, :elisp_format, :librep_format,
           :scheme_format, :smalltalk_format, :java_format, :csharp_format,
           :awk_format, :object_pascal_format, :ycp_format, :tcl_format,
           :perl_format, :perl_brace_format, :php_format, :gcc_internal_format,
           :qt_format, :qt_plural_format, :kde_format, :boost_format]

  def translated=(trans)
    self.fuzzy = !trans
  end

  def translated
    # if nil, treat as untranslated
    if self.fuzzy != nil then not self.fuzzy else false end
  end

  def to_string
    [header_string, body_string].join "\n"
  end

  def body_string
    strings = []

    raise "msgid should not be empty" if msgid.nil?
    raise "msgstr should not be empty" if msgstr.nil?

    [:msgid, :msgstr, :msgid_plural, :msgctxt].each do |mode|
      msg = send mode
      if msg
        msgs = msg.split "\n"
        strings.push "#{mode}: \"#{msgs.shift}\""
        msgs.each { |m| strings.push "\"#{m}\"" }
      end
    end

    return strings.join "\n"
  end

  def header_string
    strings = []
    strings.push "#  " + self.translator_comments if self.translator_comments
    strings.push "#. " + self.extracted_comments if self.extracted_comments
    strings.push "#: " + self.reference if self.reference
    flags = self.flag_string
    strings.push "#, " + flags if flags
    # TODO strings.push "#| " + ""
    return strings.join "\n"
  end

  def flag_string
    # Handle range separately
    flags = FLAGS.clone
    flags.delete :range
    rangestr = ""
    if self.range_from and self.range_to
      rangestr = "range: #{self.range_from}..#{self.range_to}"
    end

    # All flags
    all_flags = (flags.select { |flag| self.send(flag) })
    all_flags.push rangestr if not rangestr.empty?
    if not all_flags.empty?
        return all_flags.join ", "
    end
    return nil
  end

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
          @msg.send(mode + "=", @msg.send(mode) + "\n" + linematch[1])
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
      range_match = range.match /^range:\s(\w+)..(\w+)/
      @msg.range_from, @msg.range_to = range_match[1], range_match[2]
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
