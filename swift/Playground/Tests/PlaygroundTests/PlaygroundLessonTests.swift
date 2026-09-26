import Testing

@testable import Playground

@Suite
struct PlaygroundLessonTests {

  @Test
  func runAllLessons() {
    for lesson in PlaygroundApp.lessons {
      lesson.run()
    }
  }

  @Test
  func lessonRegistry() {
    #expect(PlaygroundApp.lessons.count == 5)
    #expect(PlaygroundApp.lessons[0].name.hasPrefix("001"))
  }
}
