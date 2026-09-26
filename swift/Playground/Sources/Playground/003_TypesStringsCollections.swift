import ArtSwift

func lesson003() {
  let implicitInteger = 70  // 编译器推断: Int
  let implicitDouble = 70.0  // 编译器推断: Double
  let explicitDouble: Double = 70  // 显式指定Double
  let explicitFloat: Float = 30.2  // 显式指定Float
  logInfo(
    "\(type(of: implicitInteger)) \(type(of: implicitDouble)) \(type(of: explicitDouble)) "
      + "\(type(of: explicitFloat))")

  let label = "The width is "
  let width = 94
  let widthLabel = label + String(width)  // 数字转换字符串必须显式
  logInfo(widthLabel)

  let apple = 3
  let orange = 5
  let appleSummary = "I have \(apple) apples"  // 值转字符串
  let fruitSummary = "I have \(apple + orange) pieces of fruit"  // 值计算后转字符串
  logInfo(appleSummary)
  logInfo(fruitSummary)

  // 多行文字,注意缩进影响
  let quotation = """
          |I said "I have \(apple) apples.*"
          *And then I said "I have \(apple + orange) pieces of fruit.|"
    """
  logInfo(quotation)

  var shoppingList = ["catfish", "water", "tulips", "blue paint"]
  shoppingList[1] = "haha"
  logInfo("\(shoppingList)")

  var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
  ]
  occupations["Jayne"] = "Public Relations"
  logInfo("\(occupations)")

  let emptyArray: [String] = []  // 初始化空数组
  let emptyDict: [String: Float] = [:]  // 初始化空字典
  logInfo("\(emptyArray) \(emptyDict)")

  // 类型可以推断场景, 直接为空
  shoppingList = []
  occupations = [:]
  logInfo("\(shoppingList) \(occupations)")
}
