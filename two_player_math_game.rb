require 'colorize'
require './Player.rb'
require './player_database.rb'
# require './ methods.rb'

#ask user if they would like to play a game
def play_game?
  keep_asking = true
  while keep_asking == true  
    puts "Do you want to start a new game? [Y]es? [N]o"
    answer = gets.chomp.downcase
    # byebug
    if valid_yes_no?(answer) && (answer == 'y' || answer == 'yes')
      keep_asking = false
      return true
    elsif valid_yes_no?(answer) && (answer =='n' || answer == 'no')
      keep_asking = false
      return false
    end    
  end

end

#is the answer a valid yes or no
def valid_yes_no? (answer)
  (answer == 'y' || answer == 'yes' || answer == 'n' || answer =='no') ? true : false
end

#promt players to setup player profile or get an old one
def init_player_profile (input_name)
  #check if player exist in player_database
  if @player_database.find {|player| player.name == input_name} != nil
    old_player = @player_database.find {|player| player.name == input_name}
    old_player.reset
    old_player
  else
    player = Player.new(input_name)
    @player_database << player
    player
  end
end

#generate math question and return an answer
def correct_answer_to_question?
  num1 = rand(1..20)
  num2 = rand(1..20)
  operator = rand(1..4)
  case operator
  when 1
    question num1, num2, :+
  when 2
    question num1, num2, :-
  when 3
    question num1, num2, :*
  else
    question num1, num2, :/
  end
end

#ask the question and promt an answer
def question (x,y,z)
  puts "What is the answer to #{x} #{z} #{y}? [Round down to nearest whole number]"
  puts x.send(z, y)
  answer = gets.chomp
  x.send(z, y).to_s == answer ? true : false
end

def update_player_score_life (correct, curr_player)
  if correct 
    curr_player.win_point
  else
    curr_player.lose_point
    curr_player.lose_life
  end
end

def update_player_database (player1, player2)
  @player_database.each do |player|
    case player
    when player1
      ind = @player_database.index(player)
      @player_database[ind] = player1
    when player2
      ind = @player_database.index(player)
      @player_database[ind] = player2
    end
  end
  return 0
end

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
  
  puts "=DATABASE=".red
  print "#{@player_database.sort_by {|player| player.num_win}}"
  
  #ask if players want to restart game
  game_on = play_game?

end
