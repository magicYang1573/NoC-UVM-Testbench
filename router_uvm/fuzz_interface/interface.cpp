#include <iostream>
#include <fstream>
#include <cstring>
#include <string>
#include <vector>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdarg.h>
#include <sys/types.h>
#include <stdio.h>
#include <sys/shm.h>
#include <stdlib.h>

#include "coverage.h"

/*#include "DirectC.h" */
/*#include "vc_hdrs.h" */
/*#include "VeriC_hdrs.h"*/

using namespace std;

#define COVERAGE_MAP_SIZE (1 << 16)

// C++ written by chatgpt

enum Result {
    Success,
    Invalid,
    Failure,
    Timeout
};

int toStatus(int v) {
    switch(v) {
        case Success:
            return 0;
        case Invalid:
            return 1 << 8;
        case Failure:
            return 6;
        case Timeout:
            return 9;
        default:
            return -1;
    }
}
static int proxy_input_hdl;
static int proxy_output_hdl;

extern "C" int waitForAFL() {
    static bool first_flag = true;
    if(first_flag) {
        proxy_input_hdl = open("../a2j", O_RDONLY);
        proxy_output_hdl = open("../j2a", O_WRONLY);
        first_flag = false;
    }
    
    char signal[4];
    int received = read(proxy_input_hdl, signal, 4);
    // printf("len=%d, %c %c %c %c\n",received, signal[0], signal[1], signal[2], signal[3]);
    return received == 4;
}

void handleResult(const unsigned char* coverage, int cov_len) {
    int result = Success; // TODO
    int status = toStatus(result);
    write(proxy_output_hdl, &status, sizeof(status));
    int len = cov_len + 1;
    write(proxy_output_hdl, &len, sizeof(len));
    char dummy = 1;
    write(proxy_output_hdl, &dummy, sizeof(dummy));
    write(proxy_output_hdl, coverage, cov_len);
}

extern "C" int sendCov2AFL(char* test_name) {
    
    vector<int64_t> cov_map;
    bool flag = get_coverage_starvation(test_name, cov_map);

    size_t cov_len = cov_map.size();
    
    unsigned char* cov_array = new unsigned char[cov_len];
    for(int i=0;i<cov_len;i++) {
        cov_array[i] = cov_map[i];
    }

    handleResult(cov_array, cov_len);
    delete cov_array;

    return flag;
}

extern "C" void getCov(char* test_name) {
    vector<int64_t> cov_map;
    get_coverage(test_name, cov_map);
    size_t cov_len = cov_map.size();

    static bool covered[10000] = {false};
    static int covered_cnt = 0;
    bool flag = false;
    for(int i=0;i<cov_len;i++) {
        if(cov_map[i] && !covered[i]) {
            covered[i] = true;
            covered_cnt ++;
            flag = true;
        }
    }
    if(flag) printf("INFO: covered %d points\n", covered_cnt);
}

