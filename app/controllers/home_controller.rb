class HomeController < ApplicationController
  
  before_filter :login_required

  def index
    @quizzs_for_me = Quizz.find_by_sql( "SELECT quizzs.* FROM quizzs LEFT OUTER JOIN follows ON quizzs.user_id = follows.followed_id WHERE follows.follower_id = #{ @me.id } ORDER BY quizzs.created_at DESC" )
    @user = @me
    get_user_info(@user)
  end
  
end
