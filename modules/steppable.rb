require 'byebug'
module Steppable
  def possible_steps(deltas)
    possible_moves = []
    deltas.each do |delta|
      x = current_pos.first
      y = current_pos.last
      x_new = x + delta.first
      y_new = y + delta.last

      next if [x_new,y_new].any? {|el| el < 0 || el > 7}
      if board[[x_new,y_new]].class == Symbol
        possible_moves << [x_new,y_new]
      elsif self.piece_color != board[[x_new,y_new]].piece_color
        possible_moves << [x_new,y_new]
      end
    end
     possible_moves
  end
end
