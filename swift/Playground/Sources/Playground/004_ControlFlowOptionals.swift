import ArtSwift

func lesson004() {
  let scores = [75, 43, 103, 87, 12]
  for score in scores {
    if score > 60 {
      logInfo("pass, score: \(score)")
    } else {
      logInfo("not pass, score: \(score)")
    }
  }

  var optName: String? = nil

  if let name = optName {
    logInfo("Succeed to convert Optional to Value, name: \(name)")
  } else {
    logInfo("Failed to convert Optional to Value")
  }
  logInfo("optName == nil: \(optName == nil)")

  optName = "Feihu"
  if let name = optName {
    logInfo("Succeed to convert Optional to Value, name: \(name)")
  } else {
    logInfo("Failed to convert Optional to Value")
  }
  logInfo("optName == nil: \(optName == nil)")

  if var name = optName {
    name = "heihei"
    logInfo("Succeed to convert Optional to Value, name: \(name)")
  }
  logInfo("optName == nil: \(optName == nil)")

  optName = nil
  logInfo("Use optName: \(optName ?? "NoValue")")  // 默认值

  optName = "Feihu"
  logInfo("Use optName: \(optName ?? "NoValue")")  // 使用当前值
}
