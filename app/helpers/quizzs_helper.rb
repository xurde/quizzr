module QuizzsHelper
  
  def url_for_quizz(quizz)
    url_for(:controller => 'quizzs', :action => 'show', :user => quizz.user.login, :id => quizz.id)
  end
  
  def link_to_quizz(quizz)
    link_to quizz.question, url_for_quizz(quizz)
  end
  
  def link_to_quizz_time(quizz)
    link_to time_ago_in_words(quizz.created_at) + ' ago', url_for_quizz(quizz)
  end
  
  def link_to_quizz_answers(quizz)
    link_to quizz.answers.size.to_s + ' answers', url_for_quizz(quizz)
  end
  
  def link_to_quizz_clues(quizz)
    link_to quizz.clues.size.to_s + ' clues', url_for_quizz(quizz)
  end
  
  
  
end
