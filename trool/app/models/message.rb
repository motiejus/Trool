class Message < ActiveRecord::Base
  belongs_to :po
end

class MessageParser
  attr_reader :all_dict;

  def initialize(content)
    @lines = content.split("\n").collect { |l| l.chomp }
  end
end
