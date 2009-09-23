class QuizzMailer < ActionMailer::Base

    helper :mailers

    def quizz_solve_notification(quizz)
      setup_email(quizz, quizz.user, quizz.winner)
      @subject    += 'Your quizz has been solved'
      @body[:quizz_url]  = "http://quizzr.net/#{quizz.user.login}/quizz/#{quizz.id.to_s}"
    end
    
    
    def quizz_solve_notification_for_players(quizz, user)
      setup_email(quizz, user, quizz.winner)
      @subject    += 'The quizz you played has been solved'
      @body[:quizz_url]  = "http://quizzr.net/#{quizz.user.login}/quizz/#{quizz.id.to_s}"
    end

    def quizz_reveal_notification_for_players(quizz, user)
      setup_email(quizz, user)
      @subject    += 'The quizz you played has been revealed'
      @body[:quizz_url]  = "http://quizzr.net/#{quizz.user.login}/quizz/#{quizz.id.to_s}"
    end
    
    def new_clue_notification_for_players(clue, user)
      setup_email(quizz, user)
      @subject    += 'The quizz you played has a new clue'
      @body[:quizz_url]  = "http://quizzr.net/#{clue.quizz.user.login}/quizz/#{clue.quizz.id.to_s}"
    end

    protected
      def setup_email(quizz, user, winner = nil)
        @recipients  = "#{user.email}"
        @from        = "\"Quizzr.net\" <no-reply@quizzr.net>"
        @reply_to    = "\"Quizzr.net\" <no-reply@quizzr.net>"
        @subject     = "[Quizzr] "
        @sent_on     = Time.now
        @body[:user] = user
        @body[:winner] = winner
        @body[:quizz] = quizz
      end
  

end
