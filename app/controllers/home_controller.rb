class HomeController < ApplicationController
  
  before_filter :login_required

  def index
    
    @user = @me
    
    case params[:filter]
    when nil
      @quizzs_for_me = Quizz.paginate_by_sql( "SELECT quizzs.* FROM quizzs LEFT OUTER JOIN follows ON quizzs.user_id = follows.followed_id WHERE follows.follower_id = #{ @me.id } ORDER BY quizzs.created_at DESC",
                                            :page => params[:page], :per_page => QUIZZS_PER_PAGE )
    when 'your'
      @quizzs_for_me = @user.quizzs.paginate( :page => params[:page], :per_page => QUIZZS_PER_PAGE )
    when 'won'
      @quizzs_for_me = @user.won_quizzs.paginate( :page => params[:page], :per_page => QUIZZS_PER_PAGE )
    when 'failed'
      @quizzs_for_me = Quizz.paginate_by_sql( "SELECT * FROM quizzs LEFT OUTER JOIN answers ON quizzs.id = answers.quizz_id WHERE answers.user_id = #{ @me.id } AND answers.ok = 0 ORDER BY quizzs.created_at DESC",
                                            :page => params[:page], :per_page => QUIZZS_PER_PAGE )
    else
      render :error, :status => 404
    end
    get_user_info(@user)
  end
  
end
