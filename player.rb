require_relative 'display.rb'

class Player
  attr_accessor :name, :display, :color
  def initialize(name, color, display)
    @name = name
    @display = display
    @color = color
  end

  def make_move
    begin
      begin
        from_pos = display.show_cursor
        if display.empty_square?(from_pos)
          raise SelectionError.new("You must select a piece!")
        end

        unless display.check_color(from_pos) == color
          raise SelectionError.new("Do not touch your opponent's pieces!")
        end
      rescue SelectionError => e
        puts e.message
        sleep(1)
        retry
      end

      begin
        to_pos = display.show_cursor
        if to_pos == from_pos
          raise DeselectionError.new("Please select a new piece.")
        end

        unless display.board.legal_move?(from_pos, to_pos)
          raise SelectionError.new("That piece can not go there!")
        end

      rescue SelectionError => e
        puts e.message
        sleep(1)
        retry
      end
      display.move_piece(from_pos,to_pos)
    rescue SelectionError => e
      puts e.message
      sleep(1)
      retry
    end
  rescue DeselectionError => e
    puts e.message
    sleep(1)
    retry
  end
end



# display = Display.new
# player = Player.new('bob', display)
# while true
#   player.make_move
#   display.render
# end
