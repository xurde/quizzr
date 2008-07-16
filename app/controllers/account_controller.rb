class AccountController < ApplicationController

  def index
  end

  def settings
    
  end

  def update_avatar
    avatar = @me.avatar || Avatar.new( :user => @me )
    flash[:notice] = 'Avatar was successfully updated.' if avatar.update_attributes( params[:avatar] )
    redirect_to :action => 'settings'
    
  end
  
end
