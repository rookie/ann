class Grid
  
  attr_accessor :size
  
  def initialize(size)
    @size = size
    @players = Array.new(2) do
      Player.new
    end
    @grid = Array.new(@size) { Array.new(@size) }

    @grid[0][0] = @players[0]
    @grid[3][3] = @players[1]

  end
  
  def display
    @grid.each do |row|
      row.each do |point|
        if point == nil
          print "0 "
        else
          print "1 "
        end
      end
      print "\n"
    end
  end

end

class Player
  attr_accessor :name, :x, :y
  
end


grid = Grid.new(4)
grid.display
p grid