class AnswersController < ApplicationController

  def create
    quizz = Quizz.find( params[:id] )
    if !quizz.nil? & quizz.is_open?
        #TODO Check that user can answer this quizz
        answer = Answer.new
        answer.quizz = quizz
        answer.user = @me
        answer.text = params[:answer]
        answer.ok = @answer_ok = quizz.check_answer(@me, params[:answer])
        answer.save
        if @answer_ok
          flash[:notice] = "You're right"
        else
          flash[:notice] = "That's wrong. You dumb!!!"
        end
        redirect_to :controller => 'quizzs', :action => 'show', :user => quizz.user.login, :id => quizz.id
    end
  end
  
end
