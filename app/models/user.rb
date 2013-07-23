class User < ActiveRecord::Base
  has_many :mylists

  has_secure_password
end
