class Mylist < ActiveRecord::Base
  belongs_to :user
  has_many :movies, :dependent => :delete_all
end
