import ArtSwift
import Foundation

@main
struct PlaygroundApp {

  static let lessons: [(name: String, run: @Sendable () -> Void)] = [
    ("001 HelloWorld", lesson001),
    ("002 VarAndLet", lesson002),
    ("003 TypesStringsCollections", lesson003),
    ("004 ControlFlowOptionals", lesson004),
    ("005 SwitchPattern", lesson005),
  ]

  static func main() {
    let args = Array(CommandLine.arguments.dropFirst())
    let selected =
      args.isEmpty
      ? lessons
      : lessons.filter { lesson in
        args.contains { lesson.name.hasPrefix($0) }
      }
    guard !selected.isEmpty else {
      logWarn("没有匹配的课程: \(args.joined(separator: " "))")
      return
    }

    logInfo("[==========] Running \(selected.count) of \(lessons.count) lessons")
    let appStart = Date()
    for (index, lesson) in selected.enumerated() {
      logInfo("[ RUN      ] \(lesson.name) (\(index + 1)/\(selected.count))")
      let start = Date()
      lesson.run()
      let ms = Int(Date().timeIntervalSince(start) * 1000)
      logInfo("[       OK ] \(lesson.name) (\(ms) ms)")
    }
    let totalMs = Int(Date().timeIntervalSince(appStart) * 1000)
    logInfo("[==========] \(selected.count) lessons finished, total \(totalMs) ms")
  }
}
