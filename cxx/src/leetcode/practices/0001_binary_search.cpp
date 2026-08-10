#include "leetcode/leetcode.hpp"

TEST(practices_binary_search_1, basic)
{
    // 标准二分查找, 数组无重复
    auto binarySearch = [](const std::vector<int>& nums, int target) -> int {
        int l = 0;
        int r = nums.size() - 1;
        while (l <= r)
        {
            int mid = l + (r - l) / 2;
            if (nums[mid] == target)
            {
                return mid;
            }
            else if (nums[mid] > target)
            {
                r = mid - 1;
            }
            else
            {
                l = mid + 1;
            }
        }
        return -1;
    };

    std::vector<int> nums = {1, 3, 5, 7, 9};
    EXPECT_EQ(binarySearch(nums, 5), 2);
    EXPECT_EQ(binarySearch(nums, 1), 0);
    EXPECT_EQ(binarySearch(nums, 9), 4);
    EXPECT_EQ(binarySearch(nums, 0), -1);
    EXPECT_EQ(binarySearch(nums, 10), -1);
}

TEST(practices_binary_search_1, findFirstEqual)
{
    // 查找第一个等于 target 的位置（下界）
    auto findFirstEqual = [](const std::vector<int>& nums, int target) -> int {
        const auto& arr = nums;
        int ans = -1;
        int l = 0;
        int r = arr.size() - 1;

        while (l <= r)
        {
            int mid = l + (r - l) / 2;
            if (arr[mid] == target)
            {
                ans = mid;
                r = mid - 1;
            }
            else if (arr[mid] < target)
            {
                l = mid + 1;
            }
            else
            {
                r = mid - 1;
            }
        }
        return ans;
    };
    std::vector<int> nums = {1, 2, 2, 2, 3, 4};
    EXPECT_EQ(findFirstEqual(nums, 2), 1);
    EXPECT_EQ(findFirstEqual(nums, 3), 4);
    EXPECT_EQ(findFirstEqual(nums, 5), -1);
}

TEST(practices_binary_search_1, findLastEqual)
{
    // 查找最后一个等于 target 的位置（上界）
    auto findLastEqual = [](const std::vector<int>& nums, int target) -> int {
        const auto& arr = nums;
        int l = 0;
        int r = arr.size() - 1;
        int ans = -1;
        while (l <= r)
        {
            int mid = l + (r - l) / 2;
            if (arr[mid] == target)
            {
                ans = mid;
                l = mid + 1;
            }
            else if (arr[mid] < target)
            {
                l = mid + 1;
            }
            else
            {
                r = mid - 1;
            }
        }
        return ans;
    };
    std::vector<int> nums = {1, 2, 2, 2, 3, 4};
    EXPECT_EQ(findLastEqual(nums, 2), 3);
    EXPECT_EQ(findLastEqual(nums, 3), 4);
    EXPECT_EQ(findLastEqual(nums, 0), -1);
}

TEST(practices_binary_search_1, lowerBound)
{
    // 查找第一个 >= target 的位置（lower_bound）
    auto lowerBound = [](const std::vector<int>& nums, int target) -> int {
        const auto& arr = nums;
        int l = 0;
        int r = arr.size() - 1;
        int ans = arr.size();
        while (l <= r)
        {
            int mid = l + (r - l) / 2;
            if (arr[mid] == target)
            {
                ans = mid;
                r = mid - 1;
            }
            else if (arr[mid] < target)
            {
                l = mid + 1;
            }
            else
            {
                ans = mid;
                r = mid - 1;
            }
        }

        return ans;
    };
    std::vector<int> nums = {1, 3, 5, 6};
    EXPECT_EQ(lowerBound(nums, 5), 2); // 第一个 >=5 的下标 2
    EXPECT_EQ(lowerBound(nums, 2), 1); // 第一个 >=2 的下标 1 (3)
    EXPECT_EQ(lowerBound(nums, 7), 4); // 全小于，返回 n
    EXPECT_EQ(lowerBound(nums, 0), 0); // 全大于，返回 0
}

TEST(practices_binary_search_1, upperBound)
{
    // 查找第一个 > target 的位置（upper_bound）
    auto upperBound = [](const std::vector<int>& nums, int target) -> int {
        const auto& arr = nums;
        int ans = arr.size();
        int l = 0;
        int r = arr.size() - 1;
        while (l <= r)
        {
            int mid = l + (r - l) / 2;
            if (arr[mid] == target)
            {
                l = mid + 1;
            }
            else if (arr[mid] < target)
            {
                l = mid + 1;
            }
            else
            {
                ans = mid;
                r = mid - 1;
            }
        }
        return ans;
    };
    std::vector<int> nums = {1, 3, 5, 6};
    EXPECT_EQ(upperBound(nums, 5), 3); // 第一个 >5 是 6，下标3
    EXPECT_EQ(upperBound(nums, 6), 4);
    EXPECT_EQ(upperBound(nums, 0), 0);
}

TEST(practices_binary_search_1, lastLessThan)
{
    // 查找最后一个 < target 的位置
    auto lastLessThan = [](const std::vector<int>& nums, int target) -> int {
        const auto& arr = nums;
        int l = 0;
        int r = arr.size() - 1;
        int ans = -1;

        while (l <= r)
        {
            int mid = l + (r - l) / 2;
            if (arr[mid] == target)
            {
                r = mid - 1;
            }
            else if (arr[mid] < target)
            {
                ans = mid;
                l = mid + 1;
            }
            else
            {
                r = mid - 1;
            }
        }
        return ans;
    };

    std::vector<int> nums = {1, 3, 5, 6};
    EXPECT_EQ(lastLessThan(nums, 5), 1);  // 3
    EXPECT_EQ(lastLessThan(nums, 1), -1); // 没有比1小的
    EXPECT_EQ(lastLessThan(nums, 7), 3);  // 6
}

TEST(practices_binary_search_1, lastLessEqual)
{
    // 查找最后一个 <= target 的位置
    auto lastLessEqual = [](const std::vector<int>& nums, int target) -> int {
        const auto& arr = nums;
        int l = 0;
        int r = arr.size() - 1;
        int ans = -1;
        while (l <= r)
        {
            int mid = l + (r - l) / 2;
            if (arr[mid] == target)
            {
                ans = mid;
                l = mid + 1;
            }
            else if (arr[mid] < target)
            {
                ans = mid;
                l = mid + 1;
            }
            else
            {
                r = mid - 1;
            }
        }
        return ans;
    };
    std::vector<int> nums = {1, 3, 5, 6};
    EXPECT_EQ(lastLessEqual(nums, 5), 2);
    EXPECT_EQ(lastLessEqual(nums, 0), -1);
    EXPECT_EQ(lastLessEqual(nums, 6), 3);
    EXPECT_EQ(lastLessEqual(nums, 66666), nums.size() - 1);
}