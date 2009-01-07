class FollowObserver < ActiveRecord::Observer
  
  def after_create(follow)
    FollowMailer.deliver_follow_notification(follow)
  end

end
