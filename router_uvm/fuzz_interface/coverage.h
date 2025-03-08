#ifndef _COVERAGE_H
#define _COVERAGE_H

#include <vector>

bool get_coverage(char* test_name, std::vector<int64_t>& cov_map_ret);
bool get_coverage_starvation(char* test_name, std::vector<int64_t>& cov_map_ret);


#endif