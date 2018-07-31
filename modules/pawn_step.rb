require 'byebug'
module PawnStep
  def possible_steps(move_deltas,kill_deltas)
    possible_moves = []
    deltas = move_deltas + kill_deltas
    deltas.each do |delta|
      x = current_pos.first
      y = current_pos.last
      x_new = x + delta.first
      y_new = y + delta.last

      next if [x_new,y_new].any? {|el| el < 0 || el > 7}
      # debugger
      if board[[x_new,y_new]].class == Symbol && move_deltas.include?(delta)
        possible_moves << [x_new,y_new]
      elsif board[[x_new,y_new]].class.superclass == Piece &&
        board[[x_new,y_new]].piece_color != self.piece_color &&
        kill_deltas.include?(delta)
        possible_moves << [x_new,y_new]
      end
    end
     possible_moves
  end
end
