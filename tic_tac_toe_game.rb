module TicTacToeGame
  def play
    Game.new
  end

  class Game
    def initialize
      # Eventually add ability for player to select
      # special symbol, so long as it's not already selected.
      @board = GameBoard.new
      puts 'Player One Info:'
      @player1 = HumanPlayer.new(input_player_name, 'X')
      puts 'Player Two Info:'
      @player2 = HumanPlayer.new(input_player_name, 'O')
      @current_player = @player1
      play_game
    end

    def play_game
      loop do
        move = get_move(@current_player)
        next unless @board.space_empty?(move) && @board.available_spaces.keys.include(move)

        @board.fill_space(move, @current_player.symbol)
        break if game_over?(move)

        @current_player =
          @current_player == @player1 ? @player2 : @player1
      end
      show_game_over
    end

    def input_player_name
      puts 'Enter Player Name:'
      gets.chomp
    end

    def get_move(current_player)
      available_moves = @board.available_spaces.keys
      puts "#{current_player.name}\'s turn"
      puts "Available moves: #{available_moves}"
      puts 'Type your next move from available list:'
      gets.chomp
    end

    def game_over?(last_move)
      # PLACEHOLDER, NEEDS TO BE IMPLEMENTED
      # check for win condition for player who most recently 
      # made a move (will be opposite of next_player)
      move_index = @board.grid_names.value(last_move)
      return three_in_a_row?(move_index) || three_in_a_column?(move_index) || three_in_a_diagonal?(move_index)
      # check diagonals of last_move  
    end

    def show_game_over
      # TO BE IMPLEMENTED
    end

    def three_in_a_row?(move_index)
      row = move_index / 3

      @board.grid_numbers[row * 3] == @board.grid_numbers[row * 3 + 1] && 
        @board.grid_numbers[row * 3] == @board.grid_numbers[row * 3 + 2]
    end

    def three_in_a_column?(move_index)
      col = move_index % 3

      @board.grid_numbers[col + 0] == @board.grid_numbers[col + 3] && 
        @board.grid_numbers[col + 0] == @board.grid_numbers[col + 6]
    end

    def three_in_a_diagonal?(move_index)
      if move_index.even?
        (@board.grid_numbers[0] == @board.grid_numbers[4] &&
          @board.grid_numbers[0] == @board.grid_numbers[8]) ||
          (@board.grid_numbers[2] == @board.grid_numbers[4] &&
          @board.grid_numbers[2] == @board.grid_numbers[6])
      else
        false
      end
    end
  end

  class GameBoard

    attr_reader :grid_numbers, :grid_names
    def initialize
      @grid_names = { topLeft: 0, topMiddle: 1, topRight: 2,
                      middleLeft: 3, middle: 4, middleRight: 5,
                      bottomLeft: 6, bottomMiddle: 7, bottomRight: 8 }
      @grid_numbers = Array.new(9)
    end

    def fill_space(int_location, symbol)
      @grid_numbers[int_location] = symbol
    end

    def space_empty?(int_location)
      (@grid_numbers[int_location]).zero?
    end

    def available_spaces
      available_indices = @grid_numbers.each_index.select { |idx| @grid_numbers[idx].zero? }
      available_indices.map { |number| @grid_names.key(number)}
    end
    
    # TODO: ADD to_s method the game board.
  end

  class HumanPlayer
    attr_reader :name, :symbol

    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
  end
end

include TicTacToeGame
play
