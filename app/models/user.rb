class User < ActiveRecord::Base
  has_many :mylists
  has_many :apis
  
  has_secure_password
end
