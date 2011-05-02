class RemoveLangFromPo < ActiveRecord::Migration
  def self.up
    remove_column :pos, :lang
  end

  def self.down
    add_column :pos, :lang, :string
  end
end
