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
  	#read in the user's move 
  	@the_move = params["the_move"]

  	#randomly create the computer's move
  	@computer_move = random_move

  	#create a new record in the database
		m = Move.new
  		m.user_move = @the_move
  		m.computer_move = @computer_move

  	# determine the outcome of play & input data
  	if @the_move == @computer_move
  		@outcome = "tied"
  		
  		m.user_wins = 0
  		m.computer_wins = 0
  		m.tie = 1
  		m.save

  	elsif @the_move == "rock" && @computer_move == "scissors"
  		@outcome = "won"

  		m.user_wins = 1
  		m.computer_wins = 0
  		m.tie = 0
  		m.save

  	elsif @the_move == "rock" && @computer_move == "paper"
  		@outcome = "lost"

  		m.user_wins = 0
  		m.computer_wins = 1
  		m.tie = 0
  		m.save

  	elsif @the_move == "paper" && @computer_move == "scissors"
  		@outcome = "lost"	

  		m.user_wins = 0
  		m.computer_wins = 1
  		m.tie = 0
  		m.save

  	elsif @the_move == "paper" && @computer_move == "rock"
  		@outcome = "won"

  		m.user_wins = 1
  		m.computer_wins = 0
  		m.tie = 0
  		m.save
  	

  	elsif @the_move == "scissors" && @computer_move == "rock"
  		@outcome = "lost"	

  		m.user_wins = 0
  		m.computer_wins = 1
  		m.tie = 0
  		m.save

  	elsif @the_move == "scissors" && @computer_move == "paper"
  		@outcome = "won"

  		m.user_wins = 1
  		m.computer_wins = 0
  		m.tie = 0
  		m.save
  	end

  	#Count the number of wins for each user move choice
  	@r_wins = Move.where({ :user_move => "rock", :user_wins => "1" }).count
  	@p_wins = Move.where({ :user_move => "paper", :user_wins => "1" }).count
  	@s_wins = Move.where({ :user_move => "scissors", :user_wins => "1" }).count
  
  	#Count the number of losses for each user move choice
  	@r_loss = Move.where({ :user_move => "rock", :computer_wins => "1" }).count
  	@p_loss = Move.where({ :user_move => "paper", :computer_wins => "1" }).count
  	@s_loss = Move.where({ :user_move => "scissors", :computer_wins => "1"}).count

  	#Count the number of ties for each user move choice
  	@r_tie = Move.where({ :user_move => "rock", :tie => "1" }).count
  	@p_tie = Move.where({ :user_move => "paper", :tie => "1" }).count
  	@s_tie = Move.where({ :user_move => "scissors", :tie => "1"}).count

  	#Sum the total of wins, losses, and ties across all user moves
  	@total_w = @r_wins + @p_wins + @s_wins
  	@total_l = @r_loss + @p_loss + @s_loss
  	@total_t = @r_tie + @p_tie + @s_tie

  	#Count the number of records in the database
  	@records = Move.count

  	#Create an array with all records in Move
  	@all_moves = Move.all

  	render("rps.html.erb")
  end

end
