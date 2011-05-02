class Po < ActiveRecord::Base
  belongs_to :pot
  has_many :messages
end
