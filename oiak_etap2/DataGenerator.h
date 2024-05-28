//
// Created by grons on 15.05.2024.
//

#ifndef OIAK_ETAP2_DATAGENERATOR_H
#define OIAK_ETAP2_DATAGENERATOR_H

#include <iostream>
#include <vector>
#include <random>

std::vector<std::pair<int,int>> generateData(int size){
    std::vector<std::pair<int,int>> matrix;

    std::random_device r;
    for(int i=0;i<size;i++){
        std::default_random_engine e1(r());
        std::uniform_int_distribution<int> uniformDist(0,1000);
        matrix.push_back(std::make_pair(uniformDist(e1),uniformDist(e1)));
    }
    return matrix;
}



#endif //OIAK_ETAP2_DATAGENERATOR_H
