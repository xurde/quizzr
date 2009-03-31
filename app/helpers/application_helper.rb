# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def flash_messages(flash)
    resp = ''
    flash.each{ |k,v| resp << content_tag(:p, v, :class => k.to_s) }
    return resp
  end  
  
  
  def asterisize(string)
    string.to_ascii_unicode.tr('a-zA-Z','*').tr('0-9', '#')
  end
  
  def gender_for_user(gender)
    case gender
    when 'M'
      ', Male'
    when 'F'
      ', Female'
    end
  end
  
  def link_to_user(user, personalize = true)
    if (personalize && user == @me)
      link_to 'You', '/' + user.login, :class => 'username'
    else
      link_to user.login, '/' + user.login, :class => 'username'
    end
  end
  
  
  def avatar_for_user(user, size = nil, linked = true )
    if !user.avatar.nil?
      avatar_path = user.avatar.public_filename(size)
    else
      avatar_path = "default-avatar#{ !size.nil? ? '-' + size.to_s : '' }.png"
    end
      image = image_tag( avatar_path, :class => "avatar #{size}" )
    if linked
      link_to image, '/' + user.login
    else
      image
    end
  end  
  
  def link_to_follow_or_remove(user)
    if (!@me.nil?) & (@me != @user)
      if user.is_followed_by?(@me)
        link_to( image_tag('button-small-follow.png'), url_for( :controller => 'users', :action => 'follow', :id => @user.id ), :method => :post )
      else
        link_to( image_tag('button-small-remove.png'), url_for( :controller => 'users', :action => 'remove', :id => @user.id ), :method => :delete )
      end
    end
  end
  
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
  
  
  # Rather Particular Cases Helpers

  def response_action_for_quizz(quizz)
    if !@me.nil?
      if quizz.is_open?
        if quizz.answered_by?(@me)
          content_tag(:h5, "You already answered #{content_tag(:strong, "'#{quizz.answer_of(@me).text}'" + "#{image_tag('icon-wrong.png') }" )} ", :class => 'answer') 
        else
          render :partial => '/answer_form_for', :object => quizz if quizz.user != @me
        end
      else
          content_tag(:h5, "#{avatar_for_user(quizz.winner, :micro)} #{link_to_user(quizz.winner)} won this quizz answering #{content_tag(:strong, "'#{quizz.correct_answer}'" + "#{( quizz.is_won_by?(@me) ? image_tag('icon-correct.png') : '' )}" ) }", :class => 'answer')
      end
    else
      content_tag( :p, "#{link_to 'login', login_url} or #{link_to 'register', signup_url} to answer this quizz.", :class => 'message' )
    end
  end
  
  def answer_by_user_for_quizz(quizz, user)
    content_tag(:h5, "<strong>#{user.login}</strong> answered #{content_tag(:strong, "'#{quizz.responded_for(user)}'" + "#{ quizz.is_won_by?(user) ? image_tag('icon-correct.png') : image_tag('icon-wrong.png') }" )} ", :class => 'answer') 
  end
  
  def winner_for_quizz(quizz)
    if !quizz.is_open?
        content_tag(:h5, "#{avatar_for_user(quizz.winner, :micro)} #{link_to_user(quizz.winner)} won this quizz answering #{content_tag(:strong, "'#{quizz.correct_answer}'" ) }", :class => 'answer')
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
