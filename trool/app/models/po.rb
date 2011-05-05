require 'ruby-debug'
require 'date'
require Rails.root.to_s + '/app/models/pot'

class Po < ActiveRecord::Base
  belongs_to :pot
  has_many :messages, :dependent => :destroy

  def output
    @po = self
    @pot = self.pot

    ## TODO: fields below
    # TODO: last edit of message?
    po_revision_date = DateTime.now.strftime("%F %T %z")
    pot_creation_date = @pot.pot_creation_date.strftime("%F %T %z")

    ret = %{# #{@pot.title}
# Copyright (C) #{@pot.first_author_year} #{@pot.first_author}
# This file is distributed under the same license as the #{@pot.name} package.
# #{@pot.first_author} <#{@pot.first_author_email}>, #{@pot.first_author_year}.
#
#, fuzzy
msgid ""
msgstr ""
"Project-Id-Version: #{@pot.project_id_version}"
"Report-Msgid-Bugs-To: #{@pot.report_msgid_bugs_to}"
"POT-Creation-Date: #{pot_creation_date}"
"PO-Revision-Date: #{po_revision_date}"
"Last-Translator: #{@pot.last_translator}"
"Language-Team: #{@pot.language_team}"
"Language: #{@po.lang}"
"MIME-Version: 1.0"
"Content-Type: #{@pot.content_type}"
"Content-Transfer-Encoding: #{@pot.content_transfer_encoding}"

} + messages_string
  end

  # Create empty messages
  def populate_messages
    potparser = PotInputParser.new self.pot.filedata
    potparser.parse_messages
    potparser.all_dict[:msg].each {|msg| self.messages.push(msg)}
  end

  # Output a substring of po file containing messages
  def messages_string
    strings = []
    self.messages.each do |msg|
      strings.push msg.to_string
    end
    return strings.join "\n\n"
  end
end
