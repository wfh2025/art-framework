import ArgumentParser
import ArtSwift
import Foundation

@main
struct WordCount: ParsableCommand {

  static let configuration = CommandConfiguration(
    abstract: "统计文件的行数/词数/字符数",
    version: "1.0.0")

  @Flag(name: .shortAndLong, help: "只输出行数")
  var lines = false

  @Flag(name: .shortAndLong, help: "只输出词数")
  var words = false

  @Flag(name: .shortAndLong, help: "只输出字符数")
  var chars = false

  @Argument(help: "输入文件路径, 缺省读 stdin")
  var file: String?

  func run() throws {
    let content: String
    if let file {
      content = try String(contentsOfFile: file, encoding: .utf8)
    } else {
      guard let text = String(data: FileHandle.standardInput.readDataToEndOfFile(), encoding: .utf8)
      else {
        throw ValidationError("stdin 不是合法的 UTF-8 文本")
      }
      content = text
    }

    let stats = TextStats.count(content)
    logInfo("input: \(file ?? "stdin"), \(stats)")

    var fields: [String] = []
    if lines { fields.append("\(stats.lines)") }
    if words { fields.append("\(stats.words)") }
    if chars { fields.append("\(stats.chars)") }
    if fields.isEmpty {
      print("\(stats.lines) \(stats.words) \(stats.chars) \(file ?? "")")
    } else {
      print(fields.joined(separator: " "))
    }
  }
}
