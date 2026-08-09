#include "leetcode/leetcode.hpp"

TEST(practices_binary_search_1, basic)
{
    // 标准二分查找, 数组无重复
    auto binarySearch = [](const std::vector<int>& nums, int target) -> int {
        int left = 0;
        int right = nums.size() - 1;
        while (left <= right)
        {
            int mid = left + (right - left) / 2;
            if (nums[mid] == target)
            {
                return mid;
            }
            else if (nums[mid] < target)
            {
                left = mid + 1;
            }
            else
            {
                right = mid - 1;
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
        int left = 0;
        int right = nums.size() - 1;
        int ans = -1;
        while (left <= right)
        {
            int mid = left + (right - left) / 2;
            if (nums[mid] == target)
            {
                ans = mid; // 记录当前，继续向左找
                right = mid - 1;
            }
            else if (nums[mid] < target)
            {
                left = mid + 1;
            }
            else
            {
                right = mid - 1;
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
        int left = 0, right = nums.size() - 1;
        int ans = -1;
        while (left <= right)
        {
            int mid = left + (right - left) / 2;
            if (nums[mid] == target)
            {
                ans = mid; // 记录当前，继续向右找
                left = mid + 1;
            }
            else if (nums[mid] < target)
            {
                left = mid + 1;
            }
            else
            {
                right = mid - 1;
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
        int left = 0, right = nums.size() - 1;
        int ans = nums.size(); // 默认插入到末尾
        while (left <= right)
        {
            int mid = left + (right - left) / 2;
            if (nums[mid] >= target)
            {
                ans = mid; // 满足条件，记录并尝试更左
                right = mid - 1;
            }
            else
            {
                left = mid + 1;
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
        int left = 0, right = nums.size() - 1;
        int ans = nums.size();
        while (left <= right)
        {
            int mid = left + (right - left) / 2;
            if (nums[mid] > target)
            {
                ans = mid;
                right = mid - 1;
            }
            else
            {
                left = mid + 1;
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
        int left = 0, right = nums.size() - 1;
        int ans = -1;
        while (left <= right)
        {
            int mid = left + (right - left) / 2;
            if (nums[mid] < target)
            {
                ans = mid; // 满足条件，尝试更右
                left = mid + 1;
            }
            else
            {
                right = mid - 1;
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
        int left = 0, right = nums.size() - 1;
        int ans = -1;
        while (left <= right)
        {
            int mid = left + (right - left) / 2;
            if (nums[mid] <= target)
            {
                ans = mid;
                left = mid + 1;
            }
            else
            {
                right = mid - 1;
            }
        }
        return ans;
    };
    std::vector<int> nums = {1, 3, 5, 6};
    EXPECT_EQ(lastLessEqual(nums, 5), 2);
    EXPECT_EQ(lastLessEqual(nums, 0), -1);
    EXPECT_EQ(lastLessEqual(nums, 6), 3);
}