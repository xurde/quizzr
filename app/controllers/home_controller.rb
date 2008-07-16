class HomeController < ApplicationController
  
  before_filter :login_required

  def index
    @followers = @me.followers
    @followings = @me.followings
    @quizzs = Quizz.find_by_sql( "SELECT quizzs.* FROM quizzs LEFT OUTER JOIN follows ON quizzs.user_id = follows.followed_id WHERE follows.follower_id = #{ @me.id } ORDER BY quizzs.created_at DESC" )
    
  end
  
end
