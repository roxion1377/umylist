class Mylist < ActiveRecord::Base
  belongs_to :user
  has_many :movies
end
