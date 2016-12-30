#include "Neuron.h"

Neuron::Neuron(unsigned numOutputs, unsigned index)
{
    for (int i = 0; i < numOutputs; ++i)
    {
        vOutputWeights.push_back(Link());
        vOutputWeights.back().weight = randomWeight();
    }

    nIndex = index;
}






void Neuron::setOutputVal(double val)
{
    dOutputVal = val;
}






double Neuron::getOutputVal() const
{
    return dOutputVal;
}






void Neuron::feedForward(const Layer &prevLayer)
{
    double sum = 0.0;

    for (unsigned i = 0; i < prevLayer.size(); ++i)
    {
        sum += prevLayer[i].getOutputVal() * prevLayer[i].vOutputWeights[nIndex].weight;
    }

    dOutputVal = transform(sum);
}






void Neuron::calcOutputGradients(double targetVal)
{
    double delta = targetVal - dOutputVal;
    dGradient = delta * dTransform(dOutputVal);
}






void Neuron::calcHiddenGradients(const Layer &nextLayer)
{
    double accu = sumAccu(nextLayer);
    dGradient = accu * dTransform(dOutputVal);
}






void Neuron::updateInputWeights(Layer& prevLayer)
{
    for (unsigned i = 0; i < prevLayer.size(); ++i)
    {
        Neuron &neuron = prevLayer[i];
        double oldDeltaWeight = neuron.vOutputWeights[nIndex].deltaWeight;

        double newDeltaWeight =
            eta * neuron.getOutputVal() * dGradient
            + alpha * oldDeltaWeight;

        neuron.vOutputWeights[nIndex].deltaWeight = newDeltaWeight;
        neuron.vOutputWeights[nIndex].weight += newDeltaWeight;
    }
}






double Neuron::transform(double x)
{
    // range [-1, 1]
    return tanh(x);
}






double Neuron::dTransform(double x)
{
    return 1.0 - tanh(x) * tanh(x);
}






double Neuron::randomWeight()
{
    return rand()/double(RAND_MAX);
}






double Neuron::sumAccu(const Layer &nextLayer) const
{
    double sum = 0.0;

    for (unsigned i = 0; i < nextLayer.size() - 1; ++i)
    {
        sum += vOutputWeights[i].weight * nextLayer[i].dGradient;
    }

    return sum;
}

