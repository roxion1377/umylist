class Movie < ActiveRecord::Base
  belongs_to :mylist
  belongs_to :user
end
