require 'ruby-debug'
require 'date'

class Po < ActiveRecord::Base
  belongs_to :pot
  has_many :messages
end

class PoGenerator
  def initialize po
    @po = po
    @pot = po.pot
  end

  def generate_string
    ## TODO: fields below

    # TODO: last edit of message?
    po_revision_date = DateTime.now.strftime("%F %T %z")
    pot_creation_date = @pot.pot_creation_date.strftime("%F %T %z")

    ret = %{
# #{@pot.title}
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
    }
  end
end
