module MailersHelper
  
  # Helpers for mailers
  
  def user_name_or_login(user)
    !user.name.nil? && !user.name.empty? ? user.name : user.login
  end
  
  
end