//
// Created by grons on 15.05.2024.
//

#ifndef OIAK_ETAP2_NEHALGORITHM_H
#define OIAK_ETAP2_NEHALGORITHM_H

#include <vector>
#include <iostream>

class NehAlgorithm {
public:
    std::vector<std::pair<int,int>> neh(std::vector<std::pair<int,int>>& tasksArr);
    int totalTime(std::vector<std::pair<int,int>>& seq);

};


#endif //OIAK_ETAP2_NEHALGORITHM_H
