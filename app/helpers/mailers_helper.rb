module MailersHelper
  
  # Helpers for mailers
  
  def user_name_or_login(user)
    !user.name.nil? && !user.name.empty? ? user.name : user.login
  end
  
  def absolute_link_to_user(user)
    link_to(user.login, "http://quizzr.net/#{user.login}" )
  end
  
  def absolute_link_to_quizz(quizz)
    link_to(quizz.question, "http://quizzr.net/#{quizz.user.login}/quizz/#{quizz.id}" )
  end
  
end