require './Player.rb'
require './player_database.rb'

#ask user if they would like to play a game
def play_game?
  keep_asking = true
  while keep_asking == true  
    puts "Do you want to start a new game? [Y]es? [N]o"
    answer = gets.chomp.downcase
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
# make array of acceptable answers
# check index for answer >= 0 (if >=0 it contains in arry)
def valid_yes_no? (answer)
#  (answer == 'y' || answer == 'yes' || answer == 'n' || answer =='no') ? true : false
  accept = ['y', 'yes', 'n', 'no'] 
  accept.index(answer) >= 0  ? true : false           
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
  return 0
end

def update_player_database (player1, player2)
  @player_database[@player_database.index(player1)] = player1
  @player_database[@player_database.index(player2)] = player2
  
  return 0
end