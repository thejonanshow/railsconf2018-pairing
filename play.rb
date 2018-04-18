class Board
  attr_reader :rows

  def initialize(size = 16)
    @rows = Array.new(size) { Array.new(size) { Cell.new } }
  end

  def cycle
    rows.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        count = 0
        # N, NE, E, SE, S, SW, W, NW
        [-1, 0, 1].each do |yoff|
          [-1, 0, 1].each do |xoff|
            next if xoff == 0 && yoff == 0
            neighbor = rows.fetch(y+yoff) { [] }.fetch(x+xoff) { Cell.new(false) }
            count += 1 if neighbor.live?
          end
        end

# live < 2, die
# live 2/3, live
# live with > 3, die
# dead with == 3, spawn

        cell.live = false
        cell.live = count == 2 || count == 3 || (!cell.live? && count == 3)
      end
    end
  end

  def printb
    rows.each do |row|
      row.each do |cell|
        print cell
      end

      puts
    end
  end
end

class Cell
  attr_accessor :live

  def initialize(state=rand(2) == 1)
    @live = state
  end

  def live?
    @live
  end

  def dead?
    !@live
  end

  def to_s
    @live ? "   ❄️   " : "  ☠️   "
  end
end

b = Board.new

b.printb

10.times do
  sleep 0.5
  b.cycle
  system 'clear'
  b.printb
end









