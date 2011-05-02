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

ActiveRecord::Schema.define(:version => 20110502185644) do

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
