class ResponsesController < ApplicationController

  def create
    quizz = Quizz.find( params[:id] )
    if !quizz.nil? & quizz.is_open?
        #TODO Check that user can response this quizz
        response = Response.new
        response.quizz = quizz
        response.user = @me
        response.ok = quizz.is_response_ok?( params[:response] )
        response.text = quizz.derandomized_option( params[:response].to_i - 1 )
        response.save
        redirect_to :controller => 'quizzs', :action => 'show', :user => quizz.user.login, :id => quizz.id
    end
  end
  
end
