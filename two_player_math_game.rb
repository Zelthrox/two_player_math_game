require 'colorize'
require './methods.rb'

game_on = true
while game_on == true
  puts "We are starting a new game!"
  
  #get player1's profile
  puts "Please input Player 1's user name"
  player_temp = gets.chomp
  player1 = init_player_profile(player_temp)
  puts "Welcome to the game #{player1.name}"
  puts player1

  #get player2's profile
  puts "Please input Player 2's user name"
  player_temp = gets.chomp
  player2 = init_player_profile(player_temp)
  puts "Welcome to the game #{player2.name}"
  puts player2

  #players takes turn playing game
  curr_player = player2
  while curr_player.life > 0 
    #change player
    curr_player == player1 ? curr_player = player2 : curr_player = player1

    #Players answer questions
    puts "==#{curr_player.name}'s Turn=="

    #Players Score and Life updated
    update_player_score_life(correct_answer_to_question?, curr_player)
    puts "#{curr_player.name}'s W/L is #{curr_player.num_win}/#{curr_player.num_loss}"
    puts "#{curr_player.name}'s life is #{curr_player.life}"
  end

  #update player_database
  update_player_database(player1, player2)

  #display game end score
  puts "=GAME OVER=".red
  puts "#{player1.name}'s W/L is #{player1.num_win}/#{player1.num_loss}".blue
  puts "#{player2.name}'s W/L is #{player2.num_win}/#{player2.num_loss}".green
  
  puts "=LADDER BOARD=".red
  print "#{(@player_database.sort_by {|player| player.num_win}).reverse}"
  
  #ask if players want to restart game
  game_on = play_game?

end
