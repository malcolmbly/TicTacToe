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
        next unless @board.available_spaces.include?(move)

        # puts 'Looped'
        #  puts @board.grid_numbers
        @board.fill_space(@board.grid_names[move], @current_player.symbol)
        break if game_over?(move)

        @current_player =
          @current_player == @player1 ? @player2 : @player1

        @board.display_board
      end
      show_game_over
    end

    def input_player_name
      puts 'Enter Player Name:'
      gets.chomp
    end

    def get_move(current_player)
      available_moves = @board.available_spaces
      puts "#{current_player.name}\'s turn"
      puts "Available moves: #{available_moves}"
      puts 'Type your next move from available list:'
      gets.chomp.to_sym
    end

    def game_over?(last_move)
      move_index = @board.grid_names[last_move]
      p move_index
      three_in_a_row?(move_index) || three_in_a_column?(move_index) || three_in_a_diagonal?(move_index)
    end

    def show_game_over
      # TO BE IMPLEMENTED
      puts 'This is the game over screen'
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
      @grid_numbers = Array.new(9, ' ')
    end

    def fill_space(int_location, playerSymbol)
      @grid_numbers[int_location] = playerSymbol
      puts @grid_numbers
    end

    def space_empty?(int_location)
      @grid_numbers[int_location] == ' '
    end

    def available_spaces
      available_indices = @grid_numbers.each_index.select { |idx| @grid_numbers[idx] == ' ' }
      available_indices.map { |number| @grid_names.key(number) }
    end

    def display_board
      puts " #{@grid_numbers[0]} | #{@grid_numbers[1]} | #{@grid_numbers[2]}"
      puts '-----------'
      puts " #{@grid_numbers[3]} | #{@grid_numbers[4]} | #{@grid_numbers[5]}"
      puts '-----------'
      puts " #{@grid_numbers[6]} | #{@grid_numbers[7]} | #{@grid_numbers[8]}"
    end
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
