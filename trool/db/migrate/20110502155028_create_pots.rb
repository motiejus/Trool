class CreatePots < ActiveRecord::Migration
  def self.up
    create_table :pots do |t|
      t.string :name
      t.string :lang

      t.timestamps
    end
  end

  def self.down
    drop_table :pots
  end
end
