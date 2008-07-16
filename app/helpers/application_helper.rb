# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def flash_messages(flash)
    resp = ''
    flash.each{ |k,v| resp << content_tag( :p, v, :class => k.to_s ) }
    return resp
  end
  
  
  def asterisize(string)
     string.tr('a-z','*')
  end
  
  def link_to_user(user)
    link_to user.login, '/' + user.login
  end
  
  
  def avatar_for_user(user, size = nil)
    if !user.avatar.nil?
      avatar_path = user.avatar.public_filename( size )
    else
      avatar_path = "avatars/default-avatar#{ !size.nil? ? '-' + size.to_s : '' }.jpg"
    end
    link_to image_tag( avatar_path, :align => 'middle' ), '/' + user.login
  end
  
  
  def link_to_quizz(quizz, text = 'question')
    case text
      when 'question'
        text_to_link = quizz.question
      when 'responses'
        text_to_link = quizz.responses.size.to_s
    end
    link_to text_to_link, url_for( :controller => 'quizzs', :action => 'show', :user => quizz.user.login, :id => quizz.id )
  end
  
end
