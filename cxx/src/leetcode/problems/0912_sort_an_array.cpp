#include "leetcode_public.hpp"

TEST(sort_an_array_912, insertionSort)
{
    class Solution
    {
    public:
        vector<int> sortArray(vector<int>& nums)
        {
            std::vector<int> res = nums;
            for (int i = 1; i < res.size(); i++)
            {
                int cur = res[i];
                int j = i - 1;
                while (true)
                {
                    if (j < 0)
                    {
                        break;
                    }
                    if (res[j] <= cur)
                    {
                        break;
                    }
                    res[j + 1] = res[j];
                    j--;
                }
                res[j + 1] = cur;
            }
            return res;
        }
    };

    auto raw = td::VEC_INT_LEN5_01;
    auto input = raw;
    auto tgt = input;

    std::sort(tgt.begin(), tgt.end());
    auto res = Solution().sortArray(input);
    EXPECT_TRUE(res == tgt);

    SPDLOG_INFO("raw: {}", td::formatVecInt(raw, false));
    SPDLOG_INFO("res: {}", td::formatVecInt(res, false));
}

TEST(sort_an_array_912, bubbleSort)
{
    class Solution
    {
    public:
        vector<int> sortArray(vector<int>& nums)
        {
            auto res = nums;
            for (int i = 0; i < ((int)res.size() - 1); i++)
            {
                bool swapped = false;
                for (int j = 0; j < ((int)res.size() - i - 1); j++)
                {
                    if (res[j] > res[j + 1])
                    {
                        std::swap(res[j], res[j + 1]);
                        swapped = true;
                    }
                }
                // 优化逻辑
                if (false == swapped)
                {
                    break;
                }
            }
            return res;
        }
    };

    auto raw = td::VEC_INT_LEN5_01;
    auto input = raw;
    auto tgt = input;

    std::sort(tgt.begin(), tgt.end());
    auto res = Solution().sortArray(input);
    EXPECT_TRUE(res == tgt);

    SPDLOG_INFO("raw: {}", td::formatVecInt(raw, false));
    SPDLOG_INFO("res: {}", td::formatVecInt(res, false));
}

TEST(sort_an_array_912, selectSort)
{
    class Solution
    {
    public:
        vector<int> sortArray(vector<int>& nums)
        {
            std::vector<int> res = nums;
            for (int i = 0; i < res.size() - 1; i++)
            {
                int minIdx = i;
                for (int j = i + 1; j < res.size(); j++)
                {
                    if (res[j] < res[minIdx])
                    {
                        minIdx = j;
                    }
                }
                if (minIdx != i)
                {
                    std::swap(res[i], res[minIdx]);
                }
            }
            return res;
        }
    };

    auto raw = td::VEC_INT_LEN5_01;
    auto input = raw;
    auto tgt = input;

    std::sort(tgt.begin(), tgt.end());
    auto res = Solution().sortArray(input);
    EXPECT_TRUE(res == tgt);

    SPDLOG_INFO("raw: {}", td::formatVecInt(raw, false));
    SPDLOG_INFO("res: {}", td::formatVecInt(res, false));
}

TEST(sort_an_array_912, mergeSort)
{
    class Solution
    {
    public:
        vector<int> sortArray(vector<int>& nums)
        {
            std::vector<int> res = nums;

            for (int len = 1; len < res.size(); len *= 2)
            {
                for (int l = 0; l < res.size() - len; l += 2 * len)
                {
                    int m = l + len - 1;
                    int r = std::min(l + 2 * len - 1, (int)res.size() - 1);
                    if (m >= r)
                    {
                        continue;
                    }
                    merge(res, l, m, r);
                }
            }

            return res;
        }
        void merge(std::vector<int>& nums, int l, int m, int r)
        {
            std::vector<int> tmp(r - l + 1);
            int i = l;
            int j = m + 1;
            int k = 0;
            while (i <= m && j <= r)
            {
                if (nums[i] <= nums[j])
                {
                    tmp[k] = nums[i];
                    i++;
                }
                else
                {
                    tmp[k] = nums[j];
                    j++;
                }
                k++;
            }
            while (i <= m)
            {
                tmp[k] = nums[i];
                i++;
                k++;
            }
            while (j <= r)
            {
                tmp[k] = nums[j];
                j++;
                k++;
            }
            for (int p = 0; p < tmp.size(); p++)
            {
                nums[l + p] = tmp[p];
            }
        }
    };

    auto raw = td::VEC_INT_LEN50000_01;
    auto input = raw;
    auto tgt = input;

    std::sort(tgt.begin(), tgt.end());
    auto res = Solution().sortArray(input);
    EXPECT_TRUE(res == tgt);

    SPDLOG_INFO("raw: {}", td::formatVecInt(raw, false));
    SPDLOG_INFO("res: {}", td::formatVecInt(res, false));
}

TEST(sort_an_array_912, mergeSort_recursive)
{
    class Solution
    {
    public:
        vector<int> sortArray(vector<int>& nums)
        {
            auto arr = nums;
            mergeSort(arr, 0, arr.size() - 1);
            return arr;
        }

        void mergeSort(std::vector<int>& arr, int left, int right)
        {
            if (left >= right)
            {
                return;
            }
            int mid = left + (right - left) / 2;
            mergeSort(arr, left, mid);
            mergeSort(arr, mid + 1, right);
            merge(arr, left, mid, right);
        }
        void merge(std::vector<int>& arr, int left, int mid, int right)
        {
            // [left, mid]
            // [mid+1, right]
            int lSize = mid - left + 1;
            int rSize = right - mid;
            std::vector<int> lVec(lSize);
            std::vector<int> rVec(rSize);

            for (int i = 0; i < lSize; i++)
            {
                lVec[i] = arr[left + i];
            }

            for (int i = 0; i < rSize; i++)
            {
                rVec[i] = arr[mid + 1 + i];
            }

            int l = 0;
            int r = 0;
            int k = left;
            while (true)
            {
                if (l >= lSize || r >= rSize)
                {
                    break;
                }
                if (lVec[l] <= rVec[r])
                {
                    arr[k] = lVec[l];
                    l++;
                }
                else
                {
                    arr[k] = rVec[r];
                    r++;
                }
                k++;
            }

            while (true)
            {
                if (l >= lSize)
                {
                    break;
                }
                arr[k] = lVec[l];
                l++;
                k++;
            }

            while (true)
            {
                if (r >= rSize)
                {
                    break;
                }
                arr[k] = rVec[r];
                r++;
                k++;
            }
        }
    };

    auto raw = td::VEC_INT_LEN50000_01;
    auto input = raw;
    auto tgt = input;

    std::sort(tgt.begin(), tgt.end());
    auto res = Solution().sortArray(input);
    EXPECT_TRUE(res == tgt);

    SPDLOG_INFO("raw: {}", td::formatVecInt(raw, false));
    SPDLOG_INFO("res: {}", td::formatVecInt(res, false));
}

TEST(sort_an_array_912, quickSort)
{
    using namespace std;

    class Solution
    {
    public:
        vector<int> sortArray(vector<int>& nums)
        {
            std::srand(std::time(nullptr));
            std::vector<int> res = nums;
            if (res.size() <= 1)
            {
                return res;
            }
            std::stack<std::pair<int, int>> stk;
            stk.push({0, res.size() - 1});

            while (!stk.empty())
            {
                int l = stk.top().first;
                int r = stk.top().second;
                stk.pop();
                if (l >= r)
                {
                    continue;
                }
                int pivotIdx = partition(res, l, r);
                if ((pivotIdx + 1) < r)
                {
                    stk.push({pivotIdx + 1, r});
                }
                if (l < (pivotIdx - 1))
                {
                    stk.push({l, pivotIdx - 1});
                }
            }
            return res;
        }

        int partition(std::vector<int>& arr, int low, int high)
        {
            // 增加随机性,可删除
            int randomIdx = low + rand() % (high - low + 1);
            std::swap(arr[randomIdx], arr[high]);

            // 小区: [low, x-1]
            // 大区: [x, i-1]
            // 扫描: i
            // 当arr[i] < pivotVal, swap(arr[x], arr[i])并且扩大小区域范围
            int pivotIndex = high;
            int x = low; // 小区边界
            for (int i = low; i < high; i++)
            { // 扫描,[low, high-1]
                if (arr[i] < arr[pivotIndex])
                {
                    std::swap(arr[x], arr[i]);
                    x++;
                }
            }
            std::swap(arr[x], arr[pivotIndex]);
            return x; // 基准值所在的索引
        }
    };

    auto raw = td::VEC_INT_LEN50000_01;
    auto input = raw;
    auto tgt = input;

    std::sort(tgt.begin(), tgt.end());
    auto res = Solution().sortArray(input);
    EXPECT_TRUE(res == tgt);

    SPDLOG_INFO("raw: {}", td::formatVecInt(raw, false));
    SPDLOG_INFO("res: {}", td::formatVecInt(res, false));
}

TEST(sort_an_array_912, heapSort)
{
    using namespace std;

    class Solution
    {
    public:
        vector<int> sortArray(vector<int>& nums)
        {
            std::vector<int> res = nums;
            if (res.size() <= 1)
            {
                return res;
            }
            for (int i = res.size() / 2 - 1; i >= 0; i--)
            {
                heapify(res, res.size(), i);
            }
            for (int i = res.size() - 1; i > 0; i--)
            {
                swap(res[0], res[i]);
                heapify(res, i, 0);
            }
            return res;
        }

    private:
        void heapify(std::vector<int>& nums, int n, int root)
        {
            while (true)
            {
                int largest = root;
                int left = 2 * root + 1;
                int right = 2 * root + 2;

                if (left < n && nums[left] > nums[largest])
                {
                    largest = left;
                }

                if (right < n && nums[right] > nums[largest])
                {
                    largest = right;
                }

                if (largest == root)
                {
                    break;
                }

                std::swap(nums[root], nums[largest]);
                root = largest;
            }
        }
    };

    auto raw = td::VEC_INT_LEN50000_01;
    auto input = raw;
    auto tgt = input;

    std::sort(tgt.begin(), tgt.end());
    auto res = Solution().sortArray(input);
    EXPECT_TRUE(res == tgt);

    SPDLOG_INFO("raw: {}", td::formatVecInt(raw, false));
    SPDLOG_INFO("res: {}", td::formatVecInt(res, false));
}