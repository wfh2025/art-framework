import Darwin
import Foundation
import Logging

public func logDebug(
  _ message: @autoclosure () -> String, file: StaticString = #fileID, line: UInt = #line
) {
  ArtLog.write(.debug, message(), file: file, line: line)
}

public func logInfo(
  _ message: @autoclosure () -> String, file: StaticString = #fileID, line: UInt = #line
) {
  ArtLog.write(.info, message(), file: file, line: line)
}

public func logWarn(
  _ message: @autoclosure () -> String, file: StaticString = #fileID, line: UInt = #line
) {
  ArtLog.write(.warning, message(), file: file, line: line)
}

public func logError(
  _ message: @autoclosure () -> String, file: StaticString = #fileID, line: UInt = #line
) {
  ArtLog.write(.error, message(), file: file, line: line)
}

public enum ArtLog {

  static let logger = Logger(label: "art.framework") { _ in ConsoleLogHandler() }

  private static let storedLevel = LockedValue(Logger.Level.info)

  public static var logLevel: Logger.Level {
    get { storedLevel.value }
    set { storedLevel.value = newValue }
  }

  static func write(_ level: Logger.Level, _ message: String, file: StaticString, line: UInt) {
    guard level >= ArtLog.logLevel else { return }
    logger.log(level: level, "\(file):\(line) | \(message)")
  }
}

// Swift 6 严格并发: 静态可变状态必须锁保护
final class LockedValue<T>: @unchecked Sendable {

  private let lock = NSLock()
  private var storage: T

  init(_ initial: T) { storage = initial }

  var value: T {
    get {
      lock.lock()
      defer { lock.unlock() }
      return storage
    }
    set {
      lock.lock()
      defer { lock.unlock() }
      storage = newValue
    }
  }
}

struct ConsoleLogHandler: LogHandler {

  var logLevel: Logger.Level = .info
  var metadata = Logger.Metadata()
  var metadataProvider: Logger.MetadataProvider? = nil

  subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
    get { metadata[metadataKey] }
    set { metadata[metadataKey] = newValue }
  }

  func log(
    level: Logger.Level,
    message: Logger.Message,
    metadata: Logger.Metadata?,
    source: String,
    file: String,
    function: String,
    line: UInt
  ) {
    let text = "\(Self.timestamp()) \(level.tag) \(message.description)"
    Self.emit(text)
  }
}

extension Logger.Level {

  var tag: String {
    let name = "[\(self)]"
    guard ConsoleLogHandler.supportsColor else { return name }
    switch self {
    case .trace: return "\u{1b}[90m\(name)\u{1b}[0m"
    case .debug: return "\u{1b}[90m\(name)\u{1b}[0m"
    case .info: return "\u{1b}[32m\(name)\u{1b}[0m"
    case .notice: return "\u{1b}[36m\(name)\u{1b}[0m"
    case .warning: return "\u{1b}[33m\(name)\u{1b}[0m"
    case .error: return "\u{1b}[31m\(name)\u{1b}[0m"
    case .critical: return "\u{1b}[35m\(name)\u{1b}[0m"
    }
  }
}

extension ConsoleLogHandler {

  private static let lock = NSLock()
  private static let formatter: DateFormatter = {
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return f
  }()

  static let supportsColor = isatty(STDOUT_FILENO) == 1

  static func timestamp() -> String {
    lock.lock()
    defer { lock.unlock() }
    return formatter.string(from: Date())
  }

  static func emit(_ text: String) {
    lock.lock()
    defer { lock.unlock() }
    FileHandle.standardOutput.write((text + "\n").data(using: .utf8)!)
  }
}
