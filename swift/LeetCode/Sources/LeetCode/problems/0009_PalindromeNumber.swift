import ArtSwift

// 9. 回文数 https://leetcode.cn/problems/palindrome-number/
func problem0009() -> Bool {
  final class Solution {
    func isPalindrome(_ x: Int) -> Bool {
      if x < 0 || (x % 10 == 0 && x != 0) {
        return false
      }
      var rev = 0
      var tmp = x
      while rev < tmp {
        rev = rev * 10 + tmp % 10
        tmp /= 10
      }
      return tmp == rev || rev / 10 == tmp
    }
  }

  let sln = Solution()
  let t = Case()
  t.expectEq(true, sln.isPalindrome(1_235_321))
  t.expectEq(true, sln.isPalindrome(123321))
  t.expectEq(false, sln.isPalindrome(-121))
  t.expectEq(true, sln.isPalindrome(121))
  t.expectEq(false, sln.isPalindrome(10))
  return t.passed
}
