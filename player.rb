require_relative 'display.rb'

class Player
  attr_accessor :name, :display
  def initialize(name, display)
    @name = name
    @display = display
  end

  def make_move
    from_pos = display.show_cursor
    to_pos = display.show_cursor
    display.move_piece(from_pos,to_pos)
  end

end

display = Display.new
player = Player.new('bob', display)
player.make_move
display.render
