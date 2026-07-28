#pragma once
#include <vector>

namespace td
{
    extern std::string formatVecInt(const std::vector<int>& vec, bool printAll, size_t headCount = 3, size_t midCount = 3, size_t tailCount = 3);
    extern const std::vector<int> VEC_INT_LEN4_01;
    extern const std::vector<int> VEC_INT_LEN4_02;
    extern const std::vector<int> VEC_INT_LEN5_01;
    extern const std::vector<int> VEC_INT_LEN6_01;
    extern const std::vector<int> VEC_INT_LEN50000_01;
} // namespace td