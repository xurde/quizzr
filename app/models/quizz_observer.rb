class QuizzObserver < ActiveRecord::Observer
  
  def after_update(quizz)
    if quizz.just_solved?
      #Notify the quizz owner
      QuizzMailer.deliver_quizz_solve_notification(quizz) if (quizz.user.notices_by_email? && quizz.user.notice_when_your_quizz_solved)
      #Notify all the players for this quizz
      quizz.answers.collect{|a| a.user}.uniq.each{|u| QuizzMailer.deliver_quizz_solve_notification_for_players(quizz, u) if (u != quizz.winner) && (u.notices_by_email? && u.notice_when_played_quizz_solved) }
    elsif quizz.just_revealed?
      quizz.answers.collect{|a| a.user}.uniq.each{|u| QuizzMailer.deliver_quizz_reveal_notification_for_players(quizz, u) if (u != quizz.winner) && (u.notices_by_email? && u.notice_when_played_quizz_solved) }
    end
  end
  
end
