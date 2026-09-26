import ArtSwift

// 704. 二分查找 https://leetcode.cn/problems/binary-search/
func problem0704() -> Bool {
  final class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
      var l = 0
      var r = nums.count - 1
      while l <= r {
        let mid = l + (r - l) / 2
        if nums[mid] == target {
          return mid
        } else if nums[mid] < target {
          l = mid + 1
        } else {
          r = mid - 1
        }
      }
      return -1
    }
  }

  let sln = Solution()
  let t = Case()
  t.expectEq(4, sln.search([-1, 0, 3, 5, 9, 12], 9))
  t.expectEq(-1, sln.search([-1, 0, 3, 5, 9, 12], 2))
  return t.passed
}
