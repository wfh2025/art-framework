import ArtSwift

final class Case {

  private(set) var total = 0
  private(set) var failed = 0

  var passed: Bool { failed == 0 }

  func expectEq<T: Equatable>(
    _ expected: T, _ actual: T, file: StaticString = #fileID, line: UInt = #line
  ) {
    total += 1
    guard expected != actual else { return }
    failed += 1
    logError("expect FAIL at \(file):\(line) | expected: \(expected), actual: \(actual)")
  }
}
