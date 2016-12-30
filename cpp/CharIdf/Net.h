#ifndef NET_H
#define NET_H

#include "Neuron.h"
#include <vector>
#include <iostream>
#include <cassert>

typedef std::vector<Neuron> Layer;


class Net
{
    public:
        Net(const std::vector<unsigned>&);
        void feedForward(const std::vector<double>&);
        void backProp(const std::vector<double>&);
        void getResults(std::vector<double>&)const;

    private:
        std::vector<Layer> vLayers; //vLayers[layerCount][neuronCount]
        double dError;
};


#endif // NET_H
