# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110503225743) do

  create_table "messages", :force => true do |t|
    t.string   "msgid",                :default => "",    :null => false
    t.string   "msgstr"
    t.string   "msgid_plural"
    t.string   "msgctxt"
    t.integer  "range_from"
    t.integer  "range_to"
    t.boolean  "fuzzy",                :default => false, :null => false
    t.integer  "po_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "translator_comments"
    t.string   "extracted_comments"
    t.string   "reference"
    t.boolean  "c_format"
    t.boolean  "objc_format"
    t.boolean  "sh_format"
    t.boolean  "python_format"
    t.boolean  "lisp_format"
    t.boolean  "elisp_format"
    t.boolean  "librep_format"
    t.boolean  "scheme_format"
    t.boolean  "smalltalk_format"
    t.boolean  "java_format"
    t.boolean  "csharp_format"
    t.boolean  "awk_format"
    t.boolean  "object_pascal_format"
    t.boolean  "ycp_format"
    t.boolean  "tcl_format"
    t.boolean  "perl_format"
    t.boolean  "perl_brace_format"
    t.boolean  "php_format"
    t.boolean  "gcc_internal_format"
    t.boolean  "gcf_internal_format"
    t.boolean  "qt_format"
    t.boolean  "qt_plural_format"
    t.boolean  "kde_format"
    t.boolean  "boost_format"
  end

  create_table "pos", :force => true do |t|
    t.string   "project"
    t.string   "translator"
    t.integer  "pot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lang"
  end

  create_table "pots", :force => true do |t|
    t.string   "name"
    t.string   "lang"
    t.string   "title"
    t.integer  "year"
    t.string   "first_author"
    t.string   "first_author_email"
    t.integer  "first_author_year"
    t.string   "project_id_version"
    t.string   "report_msgid_bugs_to"
    t.date     "pot_creation_date"
    t.string   "last_translator"
    t.string   "language_team"
    t.string   "language"
    t.string   "content_type"
    t.string   "content_transfer_encoding"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "filedata"
  end

end
