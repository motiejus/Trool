class RemoveProjectFromPot < ActiveRecord::Migration
  def self.up
    remove_column :pots, :project
  end

  def self.down
    add_column :pots, :project, :string
  end
end
