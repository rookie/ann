# global variables start with $ scoped "available across all classes"
# class variables start with @@ scoped "common to all instances of the same class"
# instance variables start with @ scoped "available to all methods of a particular instance of a class"
# local variables start with lowercase or _ scoped "only available within a particular method"

# Program order:
# (1) define global variables
# (2) define classes
# (3) define methods

#The MINIMUM function of anything calling itself a neuron is to accept an array
#of inputs, and add all of those values together.  The threshold value is
#an arbitrary constant.  Often, it is a proportional constant; say "half of all
#input lines are high"
class simple_neuron
  
  $threshold = 42
  
  attr_writer :@input_array
  
  def output_value  
    if @input_array.sum >= $threshold
      @output_value = 1
    else
      @output_value = 0
    end
  end
  
end

#the next simplest neuron is one that is capable of applying different, arbitrary
#weights to each input line.
class perceptron
  
  attr_writer :@input_array, :@weights_array
  
  def output_value
    #I don't know if I'm allowed to use the outer parenthesis this way...
    if (@input_array.zip(@weights_array).map {|x,y| x*y}).sum > $threshold
      @output_value = 1
    else
      @output_value = 0
    end
  end
  
end

#the "modern" standard is a perceptron that utilizes a non-linear activation
#function, because that is a more accurate mathematical model for the behavior
#of biological systems.  The hyperbolic tangent function is the most commonly used;
#look at its graph - it is bounded to a range of [-1,1], and is non-linear around
#zero. So if the magnitude of the input is very large, the output is still bounded to +/-1.
#Other common functions are variations on exp(-x), but they are more complicated;
#and still others use complex combinations of exponentials - but I don't see the point
#of fiddling with the activation function, unless to incorporate a second order
#transfer function (which is an impulse response - full output only occurs in a narrow
#bandwidth)
class nonlinear_perceptron

  attr_writer :@input_array, :@weights_array
  
  def output_value
    Math.tanh((@input_array.zip(@weights_array).map {|x,y| x*y}).sum)
  end
  
end

#MATT SHOULD WRITE SOME CODE HERE, BECAUSE HE ACTUALLY ALREADY WROTE IT.
#
#in your example code, replace the "player" class with either "simple_neuron",
#"perceptron", or "nonlinear_perceptron".  Make your GRID, and populate it with
#these nodes, just as you did with players.  If you link the nodes in each column
#with the nodes in the next column to the right, you have created an Artificial
#Neural Network. Sweet, huh?
#
#"But WAIT!" you may say, because you wonder "where will I get the array of weights?",
#and "how the hell can I train it to do anything useful?", and "what am I supposed 
#to do with the output?"
#
#Where does the array of weights come from: use the rand() function initially to
#populate the weight array of each node. seriously, if you don't have a well trained
#network to start with, you either use a constant, or you use random.
#
#How to train it: the modern standard for supervised learning is the "backpropagation"
#algorithm.  Crucial feature: IN ORDER TO USE BACKPROPAGATION, YOU - THE DESIGNER -
#MUST SPECIFY THE EXACT OUTPUT YOU WANT TO RECEIVE FOR A PARTICULAR INPUT. If I were
#making a neural net that could add two numbers, the input values would be numbers A
#and B, and the output value would be C.  Since I can calculate the final answer, I plug
#THAT into the output node and then do math to answer the question "What must the
#weights be on the nodes attached to my output in order to produce an output of C?"
#There will be some boundaries established for the range of the weights.  Move back to
#every node in the network, performing the same steps each time.
#
#The alternative way to train it is by randomly changing the weight array at different
#nodes.  For every possible input case that you want to train the net with, you randomly
#vary the weights on some percentage of the nodes and compare the output. With enough
#training data, and enough rounds, this will eventually train the network - but it is NOT
#efficient, and it is NOT guaranteed to find a solution.
#
#What to do with the output: Read it a bedtime story and bring it a glass of warm milk.
#Take it out skydiving, or parasailing, or hanggliding at sunset. Go grab drinks with 
#it after work. Or, print it to the console, to a file, or in a database.  It doesn't 
#really matter.



