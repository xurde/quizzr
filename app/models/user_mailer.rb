class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://quizzr.net/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://quizzr.net/"
  end
  
  def forgotten_password(user)
    setup_email(user)
    @subject    += 'Forgotten password'
    @body[:url] = "http://quizzr.net/password_reset?email=#{user.email}&token=#{user.activation_code}"
  end
  
  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset'
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "\"Quizzr.net\" <no-reply@quizzr.net>"
      @reply_to    = "\"Quizzr.net\" <no-reply@quizzr.net>"
      @subject     = "[Quizzr] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
