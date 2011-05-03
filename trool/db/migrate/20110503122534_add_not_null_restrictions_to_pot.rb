class AddNotNullRestrictionsToPot < ActiveRecord::Migration
  class Message < ActiveRecord::Base
  end
  def self.up
    change_column :messages, :msgid, :string,
      { :null => false, :default => ''}
    # change NULLs to empty strings
    Message.where("msgstr IS NULL").update_all( :msgstr => '')
  end

  def self.down
    change_column :messages, :msgid, :string,
      { :null => true, :default => nil }
  end
end
