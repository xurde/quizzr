class Newsletter < ActionMailer::Base
  
  helper :mailers
  
  def weekly_newsletter(user, most_quizzer_users, most_answered_quizzs)
    setup_email(user)
    @subject    += "Weekly activity report"
    @body[:period]  = "weekly"
    @body[:most_quizzer_users] = most_quizzer_users
    @body[:most_answered_quizzs] = most_answered_quizzs
    @body[:your_quizzs_count] = Quizz.count_by_sql("SELECT count(*) AS num_quizzs FROM users INNER JOIN quizzs ON users.id = quizzs.user_id AND users.id = #{user.id} WHERE quizzs.created_at >'2009-03-29' AND quizzs.created_at <'2009-04-06' GROUP BY users.id ORDER BY num_quizzs DESC")
    @body[:your_most_answered_quizz] = Quizz.find_by_sql("SELECT users.login, users.id, quizzs.id, quizzs.question, count(*) AS num_answers FROM users INNER JOIN quizzs ON users.id = quizzs.user_id AND users.id = #{user.id} JOIN answers ON answers.quizz_id = quizzs.id WHERE quizzs.created_at >'2009-03-29' AND quizzs.created_at <'2009-04-06' GROUP BY users.id, quizzs.id ORDER BY num_answers DESC LIMIT 1") 
  end
  
  protected
    
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "\"Quizzr.net\" <no-reply@quizzr.net>"
      @reply_to    = "\"Quizzr.net\" <no-reply@quizzr.net>"
      @subject     = "[Quizzr] "
      @sent_on     = Time.now
      @content_type = "text/html"
      @body[:user] = user
    end
  
end
