// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "LeetCode",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(path: "../ArtSwift"),
    ],
    targets: [
        .executableTarget(
            name: "LeetCode",
            dependencies: [.product(name: "ArtSwift", package: "ArtSwift")]
        ),
        .testTarget(
            name: "LeetCodeTests",
            dependencies: [.target(name: "LeetCode")]
        ),
    ]
)
