#! /usr/bin/env ruby

# global variables start with $ scoped "available across all classes"
# class variables start with @@ scoped "common to all instances of the same class"
# instance variables start with @ scoped "available to all methods of a particular instance of a class"
# local variables start with lowercase or _ scoped "only available within a particular method"

# Program order:
# (1) define global variables
# (2) define classes
# (3) define methods

class Neuron
  # Ignore this class for now.
  
  #lets say we want an instance variable of a name for each of them.
  #here is the getter
  def name
    @name #instance variable
  end
  #and the setter
  def name=(name)
    @name = name
  end

  def initialize(input_layer_arg, operation_type)
    @input_layer = input_layer_arg
    @number_of_inputs = @input_layer.length
    set_weights(@number_of_inputs)
    @neuron_type = operation_type
  end
  
  def set_weights()
    # either read some weights from the line matching the layer index in a text file,
    # or generate some random ones
    for index in 0..@number_of_inputs
      @input_weights[index] = rand()
    end
    
  end

  def sum_inputs()
    
    array_product = array_element_mult(@input_weights, @input_layer.neuron)
    
    for index in 0..array_product.length
      element_sum += array_product[index]
    end
    
    #for index in 0..@number_of_inputs
    #  @neuron_sum += @input_weights[index]*input_layer.neuron[index]
    #end
  
  end
  
  def mult_inputs()
    
    #found this online - may not work the way I want though.
    #@neuron_product = @input_weights.zip(input_layer.neuron).map {|x,y| x*y}
    
    #@neuron_product = 1   # this must be reset at 1, in case it was previously zero
    #for index in 0..@number_of_inputs
    #  @neuron_product *= @input_weights[index]*input_layer.neuron[index]
    #end
    
    array_product = array_element_mult(@input_weights, @input_layer.neuron)
    
    for index in 0..array_product.length
      element_product *= array_product[index]
    end
    
  end
  
  def rss_inputs()
  
    Math.sqrt(mult_inputs(@input_layer))
    
  end
  
  def array_element_mult(array_a, array_b)
    
    result = array_a.zip(array_b).map {|x,y| x*y}
    
  end
  
  def activation_function(value)
    Math.tanh(value)
  end
  
  def get_output()
    case @neuron_type
      when "sum"
        @neuron_value = activation_function(sum_inputs())
      when "product"
        @neuron_value = activation_function(mult_inputs())
      when "rss"
        @neuron_value = activation_function(rss_inputs())
      when "input"
        #no operation should be performed on the input, it should just read something in, and keep it.
    end 
  end 
  
  # Algorithm
  # (1) calculate the value of node n
  #   (2) look at the output lines, move to the next node that is the most effected by this result
  #   (3) estimate the value of this node, trace the lines for the next input in the list that is likely to effect the output state
  #     (4) trace back that line, then move back to 
end

class Layer
  # This class defines an object that contains an arbitrary number of neurons.  
  # This way, each neuron can be addressed by a single number within each layer.
  # The other benefit of organizing this way is that the inputs to neurons in 
  # layer n+1 can be evaluated by looping through the outputs from layer n.
  
  def initialize(type, number_of_neurons_to_make)
    # This method isn't mandatory; I used it for practice.
    
    @type_of_layer = type
    
    for neuron_count in number_of_neurons_to_make
      add_neuron(neuron_count)
    end
    
  end
  
  def add_neuron(index_location)
    # method to add a neuron in a specific location; it shouldn't do anything
    # if the index_location is lower than the number of neurons already included
    
    if index_location > @neuron.length
      @neuron[index_location] = Neuron.New
    end
    
  end
  
  def delete_neuron(index_location)
    # method to remove a neuron from a specified location; it shouldn't do anything
    # if the index_location is greater than the number of neurons in the array 
  
    # My IDE is giving me a "Feature Envy" warning on the next line - it doesn't like
    # "@neuron.length" in the comparison expression...
    if index_location <= @neuron.length
      @neuron.delete_at(index_location)
    end
    
  end
  
  def whattype?
    # This method isn't strictly necessary, but I wanted to try out the case...when stuff
    # besides, I may find a use for it later
    
    case @type_of_layer
      when 1
        "input"
      when 2
        "hidden"
      when 3
        "output"
    end
    
  end
  
  def neuroncount
    # another practice method - just wanted to see about this "returns the last thing"
    @neuron.length
  end
  
end

ARGV.each do |argument|
# ARGV is a special variable that holds any input arguments in an array as strings

  if ARGV.length > 0
    
    if File.exists?(argument)
      #this would mean that the input file exists, so we should read in parameters
      print "File exists\n"
    else # The file name doesn't exist
      #this means that the input file doesn't exist, so we should generate new parameters
      print "File doesnt exist\n"
    end
    
  else # There are no input arguments  
    print "No arguments\n"
    
    # should probably be a puts here that explains proper command line syntax,
    # or at least throws some kind of error so that you know it didn't work
    
  end
  
  #set the name of the output filename
end

# This is where some layers should be made