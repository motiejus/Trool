class RemoveFuzzyNull < ActiveRecord::Migration
  class Message < ActiveRecord::Base
  end
  def self.up
    Message.where("fuzzy IS NULL").update_all( :fuzzy => false )
    change_column :messages, :fuzzy, :boolean,
      { :null => false, :default => false }
    # change NULLs to falses
  end

  def self.down
    change_column :messages, :fuzzy, :boolean,
      { :null => true, :default => nil }
  end
end
