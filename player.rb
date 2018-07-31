require_relative 'display.rb'

class Player
  attr_accessor :name, :display
  def initialize(name, display)
    @name = name
    @display = display
  end

  def make_move
    begin
      from_pos = display.show_cursor
      if display.empty_square?(from_pos)
        raise SelectionError.new("You must select a piece!")
      end
    rescue SelectionError => e
      puts e.message
      sleep(1)
      retry
    end

    begin
      to_pos = display.show_cursor
      unless display.board.legal_move?(from_pos, to_pos)
        raise SelectionError.new("That piece can not go there!")
      end
    rescue SelectionError => e
      puts e.message
      sleep(1)
      retry
    end
    display.move_piece(from_pos,to_pos)
  end
end

class SelectionError < StandardError

end

display = Display.new
player = Player.new('bob', display)
while true
  player.make_move
  display.render
end
