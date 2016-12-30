#ifndef NEURON_H
#define NEURON_H

#include <vector>
#include <cstdlib>
#include <cmath>

class Neuron;
static double eta = 0.15; // range [0, 1]
static double alpha = 0.5; // range [0, Inf]

typedef std::vector<Neuron> Layer;

struct Link
{
    double weight;
    double deltaWeight;
};

class Neuron
{
    public:
        Neuron(unsigned, unsigned);
        void setOutputVal(double);
        double getOutputVal()const;
        void feedForward(const Layer&);
        void calcOutputGradients(double);
        void calcHiddenGradients(const Layer&);
        void updateInputWeights(Layer&);


    private:
        static double transform(double);
        static double dTransform(double);
        static double randomWeight();
        double sumAccu(const Layer&)const;
        double dOutputVal;
        std::vector<Link> vOutputWeights;
        unsigned nIndex;
        double dGradient;
};

#endif // NEURON_H
