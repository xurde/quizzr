class FollowMailer < ActionMailer::Base
  
  def follow_notification(follow)
    setup_email(follow)
    @subject    += "#{!follow.follower.name.nil? ? follow.follower.name : follow.follower.login} is now following your quizzs"
    @body[:url]  = "http://quizzr.net/#{follow.follower.login}"
  end
  
  protected
    
    def setup_email(follow)
      @recipients  = "#{follow.followed.email}"
      @from        = "\"Quizzr.net\" <no-reply@quizzr.net>"
      @reply_to    = "\"Quizzr.net\" <no-reply@quizzr.net>"
      @subject     = "[Quizzr] "
      @sent_on     = Time.now
      @body[:follow] = follow
    end
end
