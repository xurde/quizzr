class IndexController < ApplicationController

  def index
    @users = User.find(:all, :limit => 10, :order => 'created_at DESC' )
    @quizzs = Quizz.find(:all, :limit => 20, :order => 'created_at DESC' )
  end
  
end
