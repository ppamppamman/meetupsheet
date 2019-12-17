class Group < ApplicationRecord
  
  has_many :entries
  has_many :notes
  # has_many :users
  # has_many :schedules
end
