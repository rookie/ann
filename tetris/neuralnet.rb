# http://www.ai-junkie.com/ann/evolved/nnt6.html

class SNeuron
  
  attr_accessor :numInputs
  
  
  attr_accessor :weights
  
  
  def initialize(numInputs)
    self.numInputs = numInputs
    #set up the weights with an initial random value
    self.weights = Array.new(numInputs+1) { randomClamped() }
  end
  
end




class SNeuronLayar
  #number of neurons in this layer
  attr_accessor :numNeurons
  
  #layer of neurons
  attr_accessor :neurons
  
  def initialize(numNeurons, inputsPerNeuron)
    self.numNeurons = numNeurons
    self.neurons = Array.new(numNeurons) { Neuron.new(inputsPerNeuron) }
  end
  
end

class CNeuralNet
  #private
  @numInputs
  @numOutputs
  @numHiddenLayers
  @neuronsPerHiddenLayer
  #storage for each layer of neurons including the output layer
  @layers
  
  #public
  def initialize
  end
  
  def createNet
  end
  
  #gets the weights from the NN
  def getWeights
  end
  
  #returns the total number of weights in the net
  def getNumberOfWeights
  end
  
  #replaces the weights with new ones
  def putWeights(weights)
  end
  
  #calculates the outputs from a set of inputs
  def update(inputs)
    outputs = Array.new
    weight = 0
    #first check that we have the correct amount of inputs
    if inputs.size != @numInputs) do
      #just return an empty vector if incorrect.
      outputs
    end

    for i=0; i<@numHiddenLayars+1; i++ do
      
      if i > 0
        inputs = outputs
      end
      
      outputs.clear
      weight = 0
      #for each neuron sum the (inputs * corresponding weights).Throw
      #the total at our sigmoid function to get the output.
      
      
      
      
      
      
    end



  end
    
  #sigmoid response curve
  def sigmoid(activation, response)
  end
  
  
  
  
end