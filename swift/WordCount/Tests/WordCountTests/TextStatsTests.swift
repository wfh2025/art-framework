import Testing

@testable import WordCount

@Suite
struct TextStatsTests {

  @Test
  func basic() {
    let stats = TextStats.count("hello world\nfoo bar\n")
    #expect(stats.lines == 2)
    #expect(stats.words == 4)
    #expect(stats.chars == 20)
  }

  @Test
  func empty() {
    let stats = TextStats.count("")
    #expect(stats.lines == 0)
    #expect(stats.words == 0)
    #expect(stats.chars == 0)
  }

  @Test
  func noTrailingNewline() {
    let stats = TextStats.count("one two")
    #expect(stats.lines == 0)
    #expect(stats.words == 2)
  }
}
