class Board
  ALIVE = '*'
  DEAD = '_'

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def project
    grid.each do |row|
      row.each do |cell|
        print cell
      end
      puts
    end
  end

# live < 2, die
# live 2/3, live
# live with > 3, die
# dead with == 3, spawn

  def step
    Board.new(
      grid.map.with_index do |row, i|
        row.map.with_index do |cell, j|
          sum = sum_neighbors(i, j)

          case
          when sum < 2
            DEAD
          when sum == 2 || sum == 3
            ALIVE
          when sum > 3
            DEAD
          when sum == 3
            ALIVE
          else
            cell
          end
        end
      end
    )
  end

  def incremental_value(i, j)
    if (grid[i + 1][j] == ALIVE rescue nil)
      1
    else
      0
    end
  end

  def sum_neighbors(i, j)
    if i == 0
      if j == 0
        incremental_value(i + 1, j) +
        incremental_value(i, j + 1) +
        incremental_value(i + 1, j + 1)
      elsif j < grid.size - 1
        incremental_value(i, j - 1) +
        incremental_value(i + 1, j - 1) +
        incremental_value(i + 1, j) +
        incremental_value(i, j + 1) +
        incremental_value(i + 1, j + 1)
      else
        incremental_value(i + 1, j) +
        incremental_value(i, j - 1) +
        incremental_value(i + 1, j - 1)
      end
    elsif i < grid.size - 1
      incremental_value(i - 1, j) +
      incremental_value(i - 1, j + 1) +
      incremental_value(i, j + 1) +
      incremental_value(i + 1, j + 1) +
      incremental_value(i + 1, j)
    else
      0
    end
  end

  def self.seeded(size)
    Board.new(
      Array.new(size) do |i|
        Array.new(size) do |j|
          if i % 2 == 0
            if j % 2 == 1
              ALIVE
            else
              DEAD
            end
          else
            if j % 2 == 0
              ALIVE
            else
              DEAD
            end
          end
        end
      end
    )
  end
end


b = Board.seeded(10)

b.project
puts "================"

b = b.step

b.project

