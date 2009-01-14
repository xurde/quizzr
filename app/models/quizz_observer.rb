class QuizzObserver < ActiveRecord::Observer
  
  def after_update(quizz)
    if quizz.solved?
      QuizzMailer.deliver_quizz_close_notification(quizz) if (quizz.user.notices_by_email == 'A' && quizz.user.notice_when_your_quizz_solved)
    end
  end
  
end
