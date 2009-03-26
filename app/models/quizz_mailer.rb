class QuizzMailer < ActionMailer::Base

    def quizz_close_notification(quizz)
      setup_email(quizz.user, quizz.winner)
      @subject    += 'You quizz has been solved'
      @body[:quizz_url]  = "http://quizzr.net/#{quizz.user.login}/quizz/#{quizz.id.to_s}"
    end

    protected
      def setup_email(user, winner)
        @recipients  = "#{user.email}"
        @from        = "\"Quizzr.net\" <no-reply@quizzr.net>"
        @reply_to    = "\"Quizzr.net\" <no-reply@quizzr.net>"
        @subject     = "[Quizzr] "
        @sent_on     = Time.now
        @body[:user] = user
        @body[:winner] = winner
      end
  

end
