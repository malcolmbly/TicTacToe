module TicTacToeGame
  def play
    Game.new
  end

  class Game
    def initialize
      @board = GameBoard.new
      puts 'Player One Info:'
      @player1 = HumanPlayer.new(input_player_name, 'X')
      puts 'Player Two Info:'
      @player2 = HumanPlayer.new(input_player_name, 'O')
      @next_player = @player1
      play_game
    end

    def play_game
      until game_over?
        move = get_move(@next_player)
        next unless @board.space_empty?(move)

        @board.fill_space(move, next_move.symbol)
        @next_player =
          @next_player == @player1 ? @player2 : @player1
      end
    end

    def input_player_name
      puts 'Enter Player Name:'
      gets.chomp
    end

    def get_move(next_player)
      available_moves = @board.available_spaces.keys
      puts "#{next_player.name}\'s turn"
      puts "Available moves: #{available_moves}"
      puts 'Type your next move from available list:'
      gets.chomp
    end

    def game_over?
      # PLACEHOLDER, NEEDS TO BE IMPLEMENTED
      false
    end

    def show_game_over
      # TO BE IMPLEMENTED
    end
  end

  class GameBoard
    def initialize
      @grid = { topLeft: 0, topMiddle: 0, topRight: 0,
                middleLeft: 0, middle: 0, middleRight: 0,
                bottomLeft: 0, bottomMiddle: 0, bottomRight: 0 }
    end

    def fill_space(location, symbol)
      @grid[location] = symbol
    end

    def space_empty?(location)
      (@grid[location]).zero?
    end

    def available_spaces
      @grid.select { |_, symbol| symbol.zero? }
    end
    # TODO: ADD to_s method for the game board.
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
