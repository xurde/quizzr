# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def flash_messages(flash)
    resp = ''
    flash.each{ |k,v| resp << content_tag(:p, v, :class => k.to_s) }
    return resp
  end  
  
  def asterisize(string)
     string.tr('a-z','*')
  end
  
  def link_to_user(user)
    if user == @me
      link_to 'You', '/' + user.login
    else
      link_to user.login, '/' + user.login
    end
  end
  
  
  def avatar_for_user(user, size = nil)
    if !user.avatar.nil?
      avatar_path = user.avatar.public_filename(size)
    else
      avatar_path = "default-avatar#{ !size.nil? ? '-' + size.to_s : '' }.jpg"
    end
    link_to image_tag( avatar_path, :align => 'middle' ), '/' + user.login
  end
  
  
  def link_to_follow(user)
    if (!@me.nil?) & (@me != @user)
      if user.is_followed_by?(@me)
        link_to( '(follow)', url_for( :controller => 'users', :action => 'follow', :id => @user.id ))
      else
        link_to( '(unfollow)', url_for( :controller => 'users', :action => 'unfollow', :id => @user.id ))
      end
    end
  end
  
  
  def link_to_quizz(quizz)
    link_to quizz.question, url_for(:controller => 'quizzs', :action => 'show', :user => quizz.user.login, :id => quizz.id)
  end
  
  def link_to_quizz_time(quizz)
    link_to time_ago_in_words(quizz.created_at) + ' ago', url_for(:controller => 'quizzs', :action => 'show', :user => quizz.user.login, :id => quizz.id)
  end
  
  def link_to_quizz_answers(quizz)
    link_to quizz.answers.size.to_s + ' answers', url_for(:controller => 'quizzs', :action => 'show', :user => quizz.user.login, :id => quizz.id)
  end

  def response_action_for_quizz(quizz)
    if !@me.nil?
      if quizz.is_open?
        if quizz.answered_by?(@me)
          content_tag( :p, "You alredy answered #{content_tag(:strong, quizz.answer_of(@me).text)}" )
        else
          render :partial => '/answer_form_for', :object => quizz if quizz.user != @me
        end
      else
        content_tag( :p, "#{link_to_user(quizz.winner)} won this quizz answering #{content_tag(:strong, quizz.correct_answer)}" )
      end
    else
      content_tag( :p, "#{link_to 'login', login_url} or #{link_to 'signup', signup_url} to answer.", :class => 'message' )  
    end
  end

  
  # general purpose helpers
  
  def class_if(condition, class_if, class_else = nil)
    if condition
      class_if
    else
      class_else
    end
  end
  
end
