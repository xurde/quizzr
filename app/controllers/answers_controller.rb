class AnswersController < ApplicationController

  def create
    quizz = Quizz.find( params[:id] )
    if !quizz.nil?
        answer = Answer.new(:quizz => quizz, :user => @me, :text => params[:answer])
        answer.ok = quizz.validate_response(params[:answer])
        if answer.save
          if answer.ok
            quizz.win!(@me)
            flash[:notice] = "That was right"
          else
            flash[:error] = "That's not right"
          end
        else
          flash[:error] = "Are you trying to cheat me??? ¬¬"
        end
        redirect_to :controller => 'quizzs', :action => 'show', :user => quizz.user.login, :id => quizz.id
    else
      render :file => "public/404.html", :status => 404
    end
  end
  
end
