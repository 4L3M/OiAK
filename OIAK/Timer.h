//
// Created by melamela on 05.06.2024.
//

#ifndef OIAK_TIMER_H
#define OIAK_TIMER_H

#include <iostream>
#include <chrono>
using namespace std::chrono;


class Timer {

    high_resolution_clock:: time_point t0;
    high_resolution_clock:: time_point t1;
public:
    void start() {
        t0 = high_resolution_clock::now();
    }
    void stop() {
        t1 = high_resolution_clock::now();
    }

    uint64_t timeperiod() {
        duration <double> finalTime = t1 - t0;
        return (uint64_t)(finalTime.count() * 1000);
    }
};

#endif //OIAK_TIMER_H
