class IndexController < ApplicationController

  def index
    @users = User.paginate(:all, :page => 1, :per_page => 10, :limit => 10, :order => 'created_at DESC' )
    @quizzs = Quizz.paginate(:all, :page => 1, :per_page => 20, :limit => 20, :order => 'created_at DESC' )
  end
  
end
