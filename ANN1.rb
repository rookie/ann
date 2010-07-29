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
  # 

  #this is actually a place holder for now.  It's easier to think in terms of
  # "what are the inputs/outputs" than "how bout I waste a bunch of time making functions."
  # If any of them need to be updated later, I'll deal with it.
  attr_accessor :number_of_inputs, :neuron_operation

  def initialize(input_layer_object, operation_name, input_weight_array)
    number_of_inputs(input_layer_object)
    neuron_type(operation_name)
    input_weights(input_weight_array)
  end

  #also demonstrating that I get it for the setters/getters, this does a check
  #on the size of the array to ensure that it is valid.  (There must be an element
  #in the array of weights for each input node, even if those weights are zero)
  def input_weights
    if @input_weights.length == @number_of_inputs
      @input_weights
    else
      #return some kind of error to indicate that this isn't working properly
    end
  end
  
  def input_weights= (array_of_weights)
    if array_of_weights.nil? || array_of_weights.length != @number_of_inputs
      for index in 0..@number_of_inputs
        @input_weights[index] = rand()
      end
    else
      @input_weights = array_of_weights
    end
  end

  def sum_inputs
    array_element_mult(@input_weights, @input_layer.neuron).sum
  end
  
  #to get a "normal" ANN, ignore the mult_inputs method
  def mult_inputs
    array_element_mult(@input_weights, @input_layer.neuron).inject(1) {|product,n| product*n}
  end
  
  #to get a "normal" ANN, ignore the rss_inputs method
  def rss_inputs
    Math.sqrt(mult_inputs(@input_layer))
  end
  
  #made this its own method because (1) it takes arguments, and (2) it is common
  # to the sum, mult, and rss_inputs methods
  def array_element_mult(array_a, array_b)
    array_a.zip(array_b).map {|x,y| x*y}
  end
  
  #TANH is a very standard activation function; alternatives include all families
  # of 1-exp(x) - they behave similarly to TANH
  def activation_function(value)
    Math.tanh(value)
  end
  
  def neuron_value
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
  
end

#    ============================STOP HERE=======================
# HEY MATT
# on 7/29/2010, you should ignore everything below this line. I haven't updated it yet
#    ============================STOP HERE=======================

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
    
    if File.exists(argument)
      #this would mean that the input file exists, so we should read in parameters
    else # The file name doesn't exist
      #this means that the input file doesn't exist, so we should generate new parameters
    end
    
  else # There are no input arguments
    
    # should probably be a puts here that explains proper command line syntax,
    # or at least throws some kind of error so that you know it didn't work
    
  end
  
  #set the name of the output filename
end

# This is where some layers should be made