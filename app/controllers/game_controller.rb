class GameController < ApplicationController
  # This action is for the bare domain. You can ignore it.
  def home
    redirect_to("/mockup.html")
  end

  # Your code goes below.
  def random_move
  	return ["rock", "paper", "scissors"].sample
  end

  def rps
  	@the_move = params["the_move"]

  	@computer_move = random_move

  	if @the_move == @computer_move
  		@outcome = "tied"
  	elsif @the_move == "rock" && @computer_move == "scissors"
  		@outcome = "won"
  	elsif @the_move == "rock" && @computer_move == "paper"
  		@outcome = "lost"
  	elsif @the_move == "paper" && @computer_move == "scissors"
  		@outcome = "lost"	
  	elsif @the_move == "paper" && @computer_move == "rock"
  		@outcome = "won"  				
  	end

  	render("rps.html.erb")
  end

end
