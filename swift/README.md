# ArtSwift

对标 `cxx/` 的 Swift 框架：只写业务代码，不纠结构建、依赖、日志、测试。

## 分层设计（对标 CMake 的 add_subdirectory）

SPM 没有 `add_subdirectory`，等价做法是：**每个子目录是一个独立 Package**，
"这个子目录生成什么 target（可执行/模块）、依赖谁" 由它**自己的 Package.swift** 决定；
顶层不再有 Package.swift，由 `entry.sh`/`Makefile` 自动发现并遍历编排。

```
├── Makefile           # make help 查看全部命令(薄封装, 实现在 entry.sh)
├── entry.sh           # 编排: 自动发现含 Package.swift 的子目录(除 vendor), 遍历构建/测试/格式化
├── build/             # 所有构建产物统一在这里(对标 cxx/build), make clean 一键清空
│   ├── ArtSwift/      #   ArtSwift 包的产物: <配置>/...
│   ├── Playground/    #   Playground 包的产物: debug/Playground(可执行)
│   ├── LeetCode/      #   LeetCode 包的产物: debug/LeetCode(可执行)
│   └── bin/           #   可执行文件统一入口(符号链接), 对标 cxx 的 build/bin
├── vendor/            # 第三方源码, 以纯源码纳入仓库(对标 cxx/vendor)
│   ├── swift-log/     # Apple 官方日志库
│   └── swift-argument-parser/  # Apple 官方命令行参数解析库
├── ArtSwift/          # 框架核心模块包(对标 C++ 静/动态库): 日志等基础设施
│   ├── Package.swift  #   自己决定: .library 产品, 依赖 swift-log
│   ├── Sources/ArtSwift/
│   └── Tests/ArtSwiftTests/
├── Playground/        # 学习 app 包(对标 cxx/src/feat-cxx)
│   ├── Package.swift  #   自己决定: .executableTarget, 依赖 ArtSwift
│   ├── Sources/Playground/           # PlaygroundApp.swift(课程运行器) + 00N_Topic.swift
│   └── Tests/PlaygroundTests/        # 底层单元测试(逐课冒烟)
├── LeetCode/          # 刷题 app 包(对标 cxx/src/leetcode)
│   ├── Package.swift  #   自己决定: .executableTarget, 依赖 ArtSwift
│   ├── Sources/LeetCode/             # LeetCodeApp.swift + core/ + testdata/ + problems/
│   └── Tests/LeetCodeTests/          # 底层单元测试(逐题冒烟)
└── WordCount/         # 示例 app 包: 演示 app 直接调用 vendor 第三方包
    ├── Package.swift  #   自己决定: .executableTarget, 依赖 ArtSwift + swift-argument-parser
    ├── Sources/WordCount/            # TextStats.swift(统计逻辑) + WordCount.swift(CLI 入口)
    └── Tests/WordCountTests/
```

## 扩展方式

- **新增一个 app 或模块**：新建顶层目录（照抄 Playground 或 ArtSwift 整个目录改个名），
  它会被 `entry.sh build/test/format` 自动纳入，无需改任何登记表。
- **子包内加代码/测试**：按 Apple 约定 `Sources/<名字>/`、`Tests/<名字>Tests/`，
  target 由该子包自己的 Package.swift 声明。
- **加第三方库**：源码放 `vendor/`（去掉内嵌 `.git`），在需要它的子包 Package.swift 里
  `.package(path: "../vendor/<库名>")` 登记。github 直连不通时可用镜像
  `https://gitclone.com/github.com/<org>/<repo>.git`。

## 常用命令

```bash
make help     # 全部命令
make build    # 构建所有子包
make test     # 跑所有子包的单元测试
make run      # 运行 Playground 学习 app(指定课程: make run A="003 005")
make leetcode # 运行 LeetCode 刷题 app(指定题目: make leetcode A="0009 0704")
make wordcount # 运行 WordCount 示例 app(参数: make wordcount A="-l README.md")
make format   # swift-format 格式化所有子包
make deps     # vendor/ 依赖缺失时拉取
```

## Playground 学习 app

对标 `cxx/src/feat-cxx`（本质是 app，底层配套单元测试）：

- 新增课程：建 `Sources/Playground/006_Topic.swift`，写 `func lesson006() { logInfo(...) }`，
  然后在 `PlaygroundApp.lessons` 表里注册一行。
- 运行：`make run` 跑全部课程；`make run A="003 005"` 只跑指定课程（编号前缀）。

## LeetCode 刷题 app

对标 `cxx/src/leetcode`（本质是 app，底层配套单元测试，可跑指定题目）：

- 新增题目：复制 `Sources/LeetCode/problems/0000_Template.swift` 为 `NNNN_ProblemName.swift`，
  实现 `final class Solution`，用 `Case` 断言（对标 `EXPECT_EQ`），在 `LeetCodeApp.problems` 注册一行。
- 运行：`make leetcode` 跑全部题目；`make leetcode A="0009"` 只跑指定题目（编号前缀）。
- 造数：`td.createList([1,2,3])`、`td.createTree([3,9,20,nil,nil,15,7])`，
  节点类型 `ListNode`/`TreeNode`（对标 cxx 的 td 命名空间与共享结构）。

## WordCount 示例 app（调用 vendor 第三方包）

演示完整链路：第三方源码进 `vendor/` → 从 vendor 构建进 `build/WordCount/` → app 调用。

- 依赖：`swift-argument-parser`（CLI 参数解析，`@Flag`/`@Argument`/自动 `--help`）+ `ArtSwift`（日志）。
- 运行：`make wordcount A="README.md"`，或直接 `./build/bin/WordCount -l README.md`、
  `cat xx | ./build/bin/WordCount`。

## 日志

业务代码直接调用（对标 SPDLOG_XXX）：`logDebug / logInfo / logWarn / logError`，
自动带时间戳、彩色级别、源码位置。debug 默认不输出，`ArtLog.logLevel = .debug` 开启。

## 怎么写单元测试

任一子包内新增 `Tests/<模块名>Tests/FooTests.swift`，无需注册：

```swift
import ArtSwift
import Testing

@Suite
struct FooTests {

  @Test
  func case001() {
    let result = 1 + 1
    #expect(result == 2)      // 断言
    logInfo("result = \(result)")  // 日志
  }
}
```
