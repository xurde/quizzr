# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def flash_messages(flash)
    resp = ''
    flash.each{ |k,v| resp << content_tag(:p, v, :class => k.to_s) }
    return resp
  end  
  
  
  def asterisize(string)
    string.normalize.tr('a-zA-Z','*').tr('0-9', '#')
  end
  
  # Rather Particular Cases Helpers

  def response_action_for_quizz(quizz)
    if !@me.nil?
      if quizz.is_open?
        if quizz.answered_by?(@me)
          content_tag(:h5, "You already answered #{content_tag(:strong, "'#{quizz.response_by(@me).text}'" + "#{image_tag('icon-wrong.png') }" )} ", :class => 'answer') 
        else
          if quizz.user != @me
            render :partial => '/answer_form_for', :object => quizz
          else
            render :partial => '/actions_for_own_quizz', :object => quizz
          end
        end
      else
        if quizz.winner
          content_tag(:h5, "#{avatar_for_user(quizz.winner, :micro)} #{link_to_user(quizz.winner)} won this quizz answering #{content_tag(:strong, "'#{quizz.correct_answer}'" + "#{( quizz.is_won_by?(@me) ? image_tag('icon-correct.png') : '' )}" ) }", :class => 'answer')
        else
          content_tag(:h5, "The answer was revealed: #{content_tag(:strong, "'#{quizz.correct_answer}'" , :class => 'answer') }" )
        end
      end
    else
      content_tag( :p, "#{link_to 'login', login_url} or #{link_to 'register', signup_url} to answer this quizz.", :class => 'message' )
    end
  end
  
  
  def answer_by_user_for_quizz(quizz, user)
    content_tag(:h5, "<strong>#{user.login}</strong> answered #{content_tag(:strong, "'#{quizz.response_by(user)}'" + "#{ quizz.is_won_by?(user) ? image_tag('icon-correct.png') : image_tag('icon-wrong.png') }" )} ", :class => 'answer') 
  end
  
  def winner_for_quizz(quizz)
    if !quizz.is_open?
      if quizz.winner
        content_tag(:h5, "#{avatar_for_user(quizz.winner, :micro)} #{link_to_user(quizz.winner)} won this quizz answering #{content_tag(:strong, "'#{quizz.correct_answer}'" ) }", :class => 'answer')
      else
        content_tag(:h5, "The answer was revealed: #{content_tag(:strong, "'#{quizz.correct_answer}'" , :class => 'answer') }" )
      end
    else
    end
  end
  
  def quizz_parser(text, parse = { :logins => true, :urls => true })
    text.sub!(/(http:\/\/\S*)/){ |url| link_to url, url, :popup => true } if parse[:urls]
    text.sub!(/@([a-zA-Z][a-z0-9A-Z_]{2,19})/){ |login| link_to login, "/#{login.delete('@')}" } if parse[:logins]
    return text
  end
  

  # General purpose helpers
  
  def class_if(condition, class_if, class_else = nil)
    if condition
      class_if
    else
      class_else
    end
  end
  
  def external_url(url)
    url.downcase.lstrip[0..6] == 'http://' ? url : 'http://' + url
  end
  
end
