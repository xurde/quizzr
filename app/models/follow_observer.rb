class FollowObserver < ActiveRecord::Observer
  
  def after_create(follow)
    FollowMailer.deliver_follow_notification(follow) if (follow.followed.notices_by_email == 'A' && follow.followed.notice_when_new_follower)
  end

end
