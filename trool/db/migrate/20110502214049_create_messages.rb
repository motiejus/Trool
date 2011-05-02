class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :msgid
      t.string :msgstr
      t.string :msgid_plural
      t.string :msgctxt
      t.integer :range_from
      t.integer :range_to
      t.boolean :fuzzy
      t.references :po

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
