#include <iostream>
#include <vector>
#include "Net.h"
#include <fstream>
#include <cstdlib>

int main()
{

    std::vector<unsigned> topology;
    topology.push_back(3);
    topology.push_back(3);
    topology.push_back(1);
    Net myNet(topology);

    std::vector<double> inputVals, targetVals, resultVals;
    myNet.feedForward(inputVals);

    myNet.backProp(targetVals);

    myNet.getResults(resultVals);

    return 0;
}
