import Testing

@testable import LeetCode

@Suite
struct LeetCodeProblemTests {

  @Test
  func runAllProblems() {
    for problem in LeetCodeApp.problems {
      #expect(problem.run(), "题目未通过: \(problem.id)")
    }
  }

  @Test
  func testDataHelpers() {
    let list = td.createList([1, 2, 3])
    #expect(td.listToVec(list) == [1, 2, 3])

    let root = td.createTree([3, 9, 20, nil, nil, 15, 7])
    #expect(root?.val == 3)
    #expect(root?.left?.val == 9)
    #expect(root?.right?.left?.val == 15)
    #expect(root?.right?.right?.val == 7)
  }
}
