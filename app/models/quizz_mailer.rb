class QuizzMailer < ActionMailer::Base

    def quizz_close_notification(quizz)
      setup_email(quizz.user)
      @subject    += 'You quizz was solved'
      @body[:quizz_url]  = "http://quizzr.net/#{quizz.user.login}/quizzs/#{quizz.id.to_s}"
      @body[:winner_url]  = "http://quizzr.net/#{quizz.winner.login}"
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
