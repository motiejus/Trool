class CreatePos < ActiveRecord::Migration
  def self.up
    create_table :pos do |t|
      t.string :lang
      t.string :project
      t.string :translator
      t.belongs_to :pot

      t.timestamps
    end
  end

  def self.down
    drop_table :pos
  end
end
