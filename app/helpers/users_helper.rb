module UsersHelper
  
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
  
end