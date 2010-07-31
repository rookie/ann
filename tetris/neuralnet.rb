# http://www.ai-junkie.com/ann/evolved/nnt6.html

class SNeuron
  
  attr_accessor :numInputs
  
  
  attr_accessor :weights
  
  
  def initialize(numInputs)
    self.numInputs = numInputs
    #set up the weights with an initial random value
    self.weights = Array.new(numInputs+1) { randomClamped() }
  end
  
  def randomClamped 
    rand(10)+1
    #1
  end
  
end




class SNeuronLayer
  #number of neurons in this layer
  attr_accessor :numNeurons
  
  #layer of neurons
  attr_accessor :neurons
  
  def initialize(numNeurons, inputsPerNeuron)
    self.numNeurons = numNeurons
    self.neurons = Array.new(numNeurons) { SNeuron.new(inputsPerNeuron) }
  end
  
end

class CNeuralNet
  #private
  @numInputs
  @numOutputs
  @numHiddenLayers
  @neuronsPerHiddenLayer
  #storage for each layer of neurons including the output layer
  attr_reader :layers
  
  #public
  def initialize
    @numInputs  = NNParams.numInputs
    @numOutputs = NNParams.numOutputs
    @numHiddenLayers = NNParams.numHiddenLayers
    @neuronsPerHiddenLayer = NNParams.neuronsPerHiddenLayer
    
    self.createNet()
  end
  
  def createNet
    if @numHiddenLayers > 0
      @layers = Array.new
      @layers.push(SNeuronLayer.new(@neuronsPerHiddenLayer, @numInputs))
      
      #add the rest of em
      for i in 0..(@numHiddenLayers-1-1)
        puts "hello"
        
        @layers.push(SNeuronLayer.new(@neuronsPerHiddenLayer, @neuronsPerHiddenLayer))
      end
      
      #create output layer
      @layers.push(SNeuronLayer.new(@numOutputs, @neuronsPerHiddenLayer))
    else
  	  #create output layer
  	  m_vecLayers.push_back(SNeuronLayer(m_NumOutputs, m_NumInputs));
    end
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
    if inputs.size != @numInputs
      #just return an empty vector if incorrect.
      outputs
    end

    
    for i in 0..@numHiddenLayars do
    #for i=0; i<@numHiddenLayars+1; i++ do
      
      if i > 0
        inputs = outputs
      end
      
      outputs.clear
      weight = 0
      #for each neuron sum the (inputs * corresponding weights).Throw
      #the total at our sigmoid function to get the output.
      for j in 0..(@layers[i].numNeurons-1) do
        netInput = 0
        currentNumInputs = @layers[i].neurons[0].numInputs
        
        #for each weight
        for k in 0..(currentNumInputs-2) do
          #sum the weights x inputs
          netInput += @layers[i].neurons[j].weights[k] # * inputs[weight]
          weight+=1
        end
        
        #add in the bias
        netInput += @layers[i].neurons[j].weights[currentNumInputs - 1] * NNParams.bias
        
        #we can store the outputs from each layer as we generate them.
        #The combined activation is first filtered through the sigmoid
        #function
        
        outputs.push(sigmoid(netInput, NNParams.activationResponse))
        
        weight = 0;
      end
      
    end
    
    #return
    outputs
  end
    
  #sigmoid response curve
  def sigmoid(activation, response)
  end
  
  
end

class NNParams
  @@numInputs  = 10
  @@numOutputs = 1
  @@numHiddenLayers  = 1
  @@neuronsPerHiddenLayer = 5
  
  def self.numInputs; @@numInputs; end
  def self.numOutputs; @@numOutputs; end
  def self.numHiddenLayers; @@numHiddenLayers; end
  def self.neuronsPerHiddenLayer; @@neuronsPerHiddenLayer; end
  
  
  @@bias = 1
  @@activationResponse = 1
  
  def self.bias; @@bias; end
  def self.activationResponse; @@activationResponse; end
end

puts "NEURON"
one = SNeuron.new(10)
p one.numInputs
p one.weights
puts "\nLAYER (5, 10)"
lay = SNeuronLayer.new(5, 10)
p lay.numNeurons
for neuron in lay.neurons
  puts 'neuron'
  p neuron.numInputs
  p neuron.weights
end
puts "\nNET"
net = CNeuralNet.new
for layer in net.layers
  puts "LAYER with " + layer.numNeurons.to_s + " neurons"
  puts "layer inputs: " + layer.neurons[0].numInputs.to_s
  for neuron in layer.neurons
    puts 'neuron'
    puts "neurons inputs: " + neuron.numInputs.to_s
    puts "weights: "
    p neuron.weights
  end
end