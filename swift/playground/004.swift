let scores = [75, 43, 103, 87, 12]

for score in scores {
  if score > 60 {
    print("pass, score: \(score)")
  } else {
    print("not pass, score: \(score)")
  }
}

var optName: String? = nil
if let name = optName {
  print("Succeed to convert Optional to Value, name: \(name)")
} else {
  print("Failed to convert Optional to Value")
}
print(optName == nil)

optName = "Feihu"
if let name = optName {
  print("Succeed to convert Optional to Value, name: \(name)")
} else {
  print("Failed to convert Optional to Value")
}
print(optName == nil)

optName = "Feihu"
if var name = optName {
  name = "heihei"
  print("Succeed to convert Optional to Value, name: \(name)")
} else {
  print("Failed to convert Optional to Value")
}
print(optName == nil)

optName = nil
print("Use optName: \(optName ?? "NoValue")")  // 默认值

optName = "Feihu"
print("Use optName: \(optName ?? "NoValue")")  // 使用当前值
