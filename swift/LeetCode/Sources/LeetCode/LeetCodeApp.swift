import ArtSwift
import Foundation

@main
struct LeetCodeApp {

  static let problems: [(id: String, run: @Sendable () -> Bool)] = [
    ("0000 Template", problem0000),
    ("0009 PalindromeNumber", problem0009),
    ("0704 BinarySearch", problem0704),
  ]

  static func main() {
    let args = Array(CommandLine.arguments.dropFirst())
    let selected =
      args.isEmpty
      ? problems
      : problems.filter { problem in
        args.contains { problem.id.hasPrefix($0) }
      }
    guard !selected.isEmpty else {
      logWarn("没有匹配的题目: \(args.joined(separator: " "))")
      return
    }

    var passCount = 0
    logInfo("[==========] Running \(selected.count) of \(problems.count) problems")
    for (index, problem) in selected.enumerated() {
      logInfo("[ RUN      ] \(problem.id) (\(index + 1)/\(selected.count))")
      let start = Date()
      let ok = problem.run()
      let ms = Int(Date().timeIntervalSince(start) * 1000)
      if ok {
        passCount += 1
        logInfo("[       OK ] \(problem.id) (\(ms) ms)")
      } else {
        logError("[  FAILED  ] \(problem.id) (\(ms) ms)")
      }
    }
    logInfo("[==========] \(passCount)/\(selected.count) problems passed")
  }
}
