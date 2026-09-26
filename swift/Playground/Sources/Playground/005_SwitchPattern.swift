import ArtSwift

func lesson005() {
  let vegetable = "red pepper"

  switch vegetable {
  case "celery":
    logInfo("Add some raisins and make ants on a log.")
  case "cucumber", "watercress":
    logInfo("That would make a good tea sandwich.")
  case let x where x.hasSuffix("pepper"):  // x是拷贝
    logInfo("Is it a spicy \(x)?")
  default:
    logInfo("Everything tastes good in soup.")
  }
}
