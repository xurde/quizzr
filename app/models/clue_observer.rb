class ClueObserver < ActiveRecord::Observer
  
  def after_create(clue)
    clue.quizz.answers.collect{|a| a.user}.uniq.each{|u| QuizzMailer.deliver_new_clue_notification_to_players(clue, u) if u.notices_by_email? && u.notice_when_new_clues }
  end
  
end
