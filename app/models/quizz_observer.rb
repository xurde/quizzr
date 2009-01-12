class QuizzObserver < ActiveRecord::Observer
  
  def after_update(quizz)
    if @solved
      QuizzMailer.deliver_quizz_close_notification(quizz)
    end
  end
  
end
