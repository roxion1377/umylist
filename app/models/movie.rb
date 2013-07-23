class Movie < ActiveRecord::Base
  belongs_to :mylist
  belongs_to :user

  validates :sm_id, :presence => {:message => 'sm_id'}
  validates_presence_of :sm_id,{:scope => :mylist_id,:message => 'juufuku'}
  
  validates :thread_id, :presence => {:message => 'thread_id'},:numericality => {:message => 'thread suuji'}
  
  validates :mylist_id, :presence =>{:message => 'mylist_id'}
  
end
