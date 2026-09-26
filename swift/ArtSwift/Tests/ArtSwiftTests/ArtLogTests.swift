import ArtSwift
import Testing

@Suite(.serialized)  // 用例间共享可变的日志级别
struct ArtLogTests {

  @Test
  func defaultLevel() {
    #expect(ArtLog.logLevel == .info)
  }

  @Test
  func setLevel() {
    let saved = ArtLog.logLevel
    defer { ArtLog.logLevel = saved }

    ArtLog.logLevel = .debug
    #expect(ArtLog.logLevel == .debug)
  }

  @Test
  func smokeAllLevels() {
    logDebug("debug")
    logInfo("info")
    logWarn("warn")
    logError("error")
  }
}
