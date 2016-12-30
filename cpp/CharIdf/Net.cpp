#include "Net.h"

Net::Net(const std::vector<unsigned> &topology)
{
    unsigned numLayers = topology.size();
    //create Layers
    for (unsigned layerNum = 0; layerNum < numLayers; ++layerNum)
    {
        vLayers.push_back(Layer());
        unsigned numOutputs = layerNum == topology.size() - 1 ? 0 : topology[layerNum + 1];

        //add Neurons
        for (unsigned neuronNum = 0; neuronNum <= topology[layerNum]; ++neuronNum)
        {
            vLayers.back().push_back(Neuron(numOutputs, neuronNum));
            std::cout << "Neuron Created" << std::endl;
        }
    }

    // Bias unit
    vLayers.back().back().setOutputVal(1.0);
}






void Net::feedForward(const std::vector<double>& inputVals)
{
    assert(inputVals.size() == vLayers[0].size() - 1);

    for (int i = 0; i < inputVals.size(); ++i)
    {
        vLayers[0][i].setOutputVal(inputVals[i]);
    }

    for (unsigned layerNum = 1; layerNum < vLayers.size(); ++layerNum)
    {
        Layer &prevLayer = vLayers[layerNum - 1];
        for (int j = 0; j < vLayers[layerNum].size() - 1; ++j)
        {
            vLayers[layerNum][j].feedForward(prevLayer);
        }
    }
}






void Net::backProp(const std::vector<double>& targetVals)
{

    // calculate error
    Layer &outputLayer = vLayers.back();
    dError = 0.0;

    for (unsigned i = 0; i < outputLayer.size() - 1; ++i)
    {
        double delta = targetVals[i] - outputLayer[i].getOutputVal();
        dError += delta * delta;
    }
    dError /= outputLayer.size() - 1;

    // calculate output gradients
    for (unsigned i = 0; i < outputLayer.size() - 1; ++i)
    {
        outputLayer[i].calcOutputGradients(targetVals[i]);
    }

    // calculate hidden gradients
    for (unsigned layerNum = vLayers.size() - 2; layerNum > 0; --layerNum)
    {
        Layer &hiddenLayer = vLayers[layerNum];
        Layer &nextLayer = vLayers[layerNum + 1];

        for (unsigned i = 0; i < hiddenLayer.size(); ++i)
        {
            hiddenLayer[i].calcHiddenGradients(nextLayer);
        }
    }

    //update weights
    for (unsigned layerNum = vLayers.size() - 1; layerNum > 0; --layerNum)
    {
        Layer &layer = vLayers[layerNum];
        Layer &prevLayer = vLayers[layerNum - 1];

        for (unsigned i = 0; i < layer.size() - 1; ++i)
        {
            layer[i].updateInputWeights(prevLayer);
        }
    }
}






void Net::getResults(std::vector<double>& resultVals) const
{
    resultVals.clear();

    for (unsigned i = 0; i < vLayers.back().size() - 1; ++i)
    {
        resultVals.push_back(vLayers.back()[i].getOutputVal());
    }
}
