final class ListNode {
  var val: Int
  var next: ListNode?

  init(_ val: Int, _ next: ListNode? = nil) {
    self.val = val
    self.next = next
  }
}

final class TreeNode {
  var val: Int
  var left: TreeNode?
  var right: TreeNode?

  init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
    self.val = val
    self.left = left
    self.right = right
  }
}
