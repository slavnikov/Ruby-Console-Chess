require 'byebug'
module Slidable
  def possible_slides(deltas)
    possible_moves = []
    deltas.each do |delta|
      stopped = false
      x = current_pos.first
      y = current_pos.last
      x_new = x + delta.first
      y_new = y + delta.last

      until stopped || [x_new,y_new].any? {|el| el < 0 || el > 7}
        if board[[x_new,y_new]].class == Symbol
          possible_moves << [x_new,y_new]
          x_new += delta.first
          y_new += delta.last
        elsif self.piece_color != board[[x_new,y_new]].piece_color
          possible_moves << [x_new,y_new]
          stopped = true
        else
          stopped = true
        end
      end
    end
     possible_moves
  end
end
