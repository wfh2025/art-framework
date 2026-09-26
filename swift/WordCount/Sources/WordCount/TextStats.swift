struct TextStats: CustomStringConvertible {
  let lines: Int
  let words: Int
  let chars: Int

  var description: String { "lines: \(lines), words: \(words), chars: \(chars)" }

  static func count(_ text: String) -> TextStats {
    TextStats(
      lines: text.filter { $0 == "\n" }.count,
      words: text.split(whereSeparator: \.isWhitespace).count,
      chars: text.count
    )
  }
}
