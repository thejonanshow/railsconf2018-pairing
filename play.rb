# live < 2, die
# live 2/3, live
# live with > 3, die
# dead with == 3, spawn

class World
  def initialize(grid, population = 50)
    @grid = grid
    @population = population
    @grid.populate(population)
  end

  def explore
    puts @grid 
  end

  def tng
    the_ng = Grid.new(@grid.size)

    @grid.cells.each do |cell|
      @grid.live_neighbours_count(cell)
    end
  end
end

class Cell
  attr_accessor :state

  def initialize(state = :dead)
    @state = state
  end

  def alive?
    !dead?
  end

  def rebirth
    self.state = :alive
  end

  def die
    self.state = :dead
  end

  def dead?
    state == :dead
  end

  def to_s
    alive? ? "🤓 " : "😵 "
  end
end

class Grid
  attr_reader :size

  def initialize(size)
    @size = size
    @actual_grid = Array.new(size) { Array.new(size) { Cell.new } }
  end

  def live_neighbours_count(cell)
    x, y = cell.location

    if x == 0
      if y == 0
      end
    elsif x >= @size
      if y >= @size
      end
    end

    n = @actual_grid[y - 1][x]
    ne = @actual_grid[y - 1][x + 1]
    nw = @actual_grid[y - 1][x - 1]
    sw = @actual_grid[y + 1][x - 1]
    w = @actual_grid[y][ x - 1]

    e = @actual_grid[y][x + 1]
    se = @actual_grid[y + 1][x + 1]
    s = @actual_grid[y + 1][x]

    [n, ne, e, se, sw, w, nw].select(&:alive?).count
  end

  def cells
    @actual_grid.flatten
  end

  def populate(population_percentage)
    @actual_grid.flatten.each do |cell|
      r = rand(1..100)
      cell.rebirth if r <= population_percentage
    end
  end

  def to_s
    @actual_grid.each do |row|
      row.each do |cell|
        print cell
      end

      puts
    end
  end
end

world = World.new(Grid.new(3), 35)
world.explore
world.tng
world.explore









