class Follow < ActiveRecord::Base

=begin
  TODO Delete follow on cascade
=end
  
  belongs_to :follower, :class_name => 'User', :foreign_key => 'follower_id'
  belongs_to :followed, :class_name => 'User', :foreign_key => 'followed_id'
  validates_uniqueness_of   :follower, :followed, :case_sensitive => false
  
end
