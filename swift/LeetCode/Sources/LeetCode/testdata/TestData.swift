enum td {

  static func createList(_ arr: [Int]) -> ListNode? {
    let head = ListNode(0)
    var tail = head
    for v in arr {
      tail.next = ListNode(v)
      tail = tail.next!
    }
    return head.next
  }

  static func listToVec(_ head: ListNode?) -> [Int] {
    var vec: [Int] = []
    var node = head
    while let cur = node {
      vec.append(cur.val)
      node = cur.next
    }
    return vec
  }

  // 层序构建, nil 为空位; 例: [3, 9, 20, nil, nil, 15, 7]
  static func createTree(_ vals: [Int?]) -> TreeNode? {
    guard let rootVal = vals.first, let rootVal = rootVal else { return nil }
    let root = TreeNode(rootVal)
    var queue = [root]
    var i = 1
    while i < vals.count, !queue.isEmpty {
      let node = queue.removeFirst()
      if i < vals.count {
        if let v = vals[i] {
          node.left = TreeNode(v)
          queue.append(node.left!)
        }
        i += 1
      }
      if i < vals.count {
        if let v = vals[i] {
          node.right = TreeNode(v)
          queue.append(node.right!)
        }
        i += 1
      }
    }
    return root
  }
}
