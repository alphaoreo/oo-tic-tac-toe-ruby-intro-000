class TicTacToe
  def initialize
    @board= [" "," "," "," "," "," "," "," "," "]
    @WIN_COMBINATIONS= [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,4,8],
      [2,4,6],
      [0,3,6],
      [1,4,7],
      [2,5,8]
    ]
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1= win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
      if @board[win_index_3] == @board[win_index_2] && @board[win_index_2] == @board[win_index_1] && (@board[win_index_1] == "X" || @board[win_index_1]=="O")
        return win_combination
      end
    end
    return false
  end

  def full?
    !(@board.include?(" "))
  end

  def draw?
    !(won?) && full?
  end

  def over?
    draw? || won?
  end

  def winner
    result= won?
    if result
      return @board[result[0]]
    end
  end

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index
    puts "Please enter 1-9:"
    input = gets.strip
    index=input -1
    @current_spot=index
  end

  def turn
    choice=input_to_index
    if valid_move?
      move
      display_board
    else
      turn
    end
  end

  def move
    @board[@current_spot]= @current_player
  end

  def position_taken?
    @board[@current_spot] != " "
  end

  def valid_move?
    @current_spot.between(0,8) && !position_taken?
  end

  def turn_count
    level=0
    @board.each do |spot|
      if spot == "X" || spot =="O"
        level += 1
      end
    end
    return level
  end

  def current_player
    player = ""
    level = turn_count
    if level % 2 == 0
      player = "X"
    else
      player= "O"
    end
    @current_player = player
  end

  def play
    while !(over?) do
      current_player
      turn
    end
    if won?
      champ= winner
      puts "Congratulations #{champ}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
