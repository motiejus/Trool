class CreatePots < ActiveRecord::Migration
  def self.up
    create_table :pots do |t|
      t.string :name
      t.string :lang
      t.string :title
      t.integer :year
      t.string :first_author
      t.string :first_author_email
      t.integer :first_author_year
      t.string :project_id_version
      t.string :report_msgid_bugs_to
      t.date :pot_creation_date
      t.string :last_translator
      t.string :language_team
      t.string :language
      t.string :content_type
      t.string :content_transfer_encoding

      t.timestamps
    end
  end

  def self.down
    drop_table :pots
  end
end
