
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
