class AddDataToPot < ActiveRecord::Migration
  def self.up
    add_column :pots, :filedata, :text
  end

  def self.down
    remove_column :pots, :filedata
  end
end
