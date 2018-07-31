require_relative 'player.rb'
require 'byebug'

class Chess
  attr_accessor :current_player
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @display = Display.new
    @board = @display.board
    @player1 = Player.new(player1,:red, @display)
    @player2 = Player.new(player2,:blue,@display)
    @current_player = @player1
  end

  def take_turn
    @board.current_player = current_player
    @current_player.make_move
  end

  def run
    while true
      take_turn
      switch_player
    end
  end

  def switch_player
    # debugger
    self.current_player = current_player == player1 ? player2 : player1
  end
end

game = Chess.new('bob', 'todd')
game.run
