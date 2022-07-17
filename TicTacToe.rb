module TicTacToeGame
  def play
    Game.new
  end

  class Game
    def initialize
      @board = GameBoard.new
      puts 'Player One Info:'
      @player1 = HumanPlayer.new(input_player_name, "X")
      puts 'Player Two Info:'
      @player2 = HumanPlayer.new(input_player_name, "O")
      @next_move = @player1
      take_turn(@next_move)
    end

    def input_player_name()
      puts 'Enter Player Name:'
      gets.chomp
    end

    def take_turn(next_move)
      puts "#{next_move.name}\'s turn\n"
      available_moves = @board.available_spaces.keys
      puts "Available moves: #{available_moves}"
      puts 'Type your next move from available list:\n'
      move = gets.chomp
      if available_moves.include?(move)
        @board.fill_space(move, next_move.symbol)
        next_move = 
          next_move == @player1 ? @player2 : @player1 
      end
      take_turn(next_move) unless game_over?
    end

    def game_over?
      #PLACEHOLDER, NEEDS TO BE IMPLEMENTED
      false
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

    def available_spaces()
      @grid.select { |_, symbol| symbol.zero? }
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
