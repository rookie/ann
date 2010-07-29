class Grid
  
  attr_accessor :size
  
  def initialize(size)
    @size = size
    
    @players = Array.new(5) do
      Player.new
    end
    
    @grid = Array.new(@size) { Array.new(@size) }

    #place the players in their corners
    #@grid[0][0] = @players[0]
    #@grid[@grid.size-1][@grid.size-1] = @players[1]
    self.place_players
    
  end
  
  def clear
    @grid.each do |row|
      row.each do |point|
        point = nil
      end
    end
  end
  
  def place_players
    self.clear
    @players.each do |player|
      placed = false
      while !placed do
        puts "try placing"
        x = rand(@size)
        y = rand(@size)
        puts x.to_s + ", " + y.to_s
        if @grid[x][y].nil? 
          @grid[x][y] = player
          placed = true
          puts "placed"
        end
      end
    end
  end
  
  def display
    @grid.each do |row|
      row.each do |point|
        if point == nil
          print "0 "
        else
          print point.name + " "
        end
      end
      print "\n"
    end
  end

end

class Player
  attr_accessor :name, :x, :y
  @@index = 1
  def initialize()
    @name = @@index.to_s
    @@index += 1;
  end
  
end


puts "\nCreate grid\n-----------"
grid = Grid.new(4)
puts "\nGrid created\n------------"
grid.display
