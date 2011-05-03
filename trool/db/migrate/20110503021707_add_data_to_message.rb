class AddDataToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :translator_comments, :string
    add_column :messages, :extracted_comments, :string
    add_column :messages, :reference, :string
  end

  def self.down
    remove_column :messages, :reference
    remove_column :messages, :extracted_comments
    remove_column :messages, :translator_comments
  end
end
