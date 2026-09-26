// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "WordCount",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(path: "../ArtSwift"),
        .package(path: "../vendor/swift-argument-parser"),
    ],
    targets: [
        .executableTarget(
            name: "WordCount",
            dependencies: [
                .product(name: "ArtSwift", package: "ArtSwift"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "WordCountTests",
            dependencies: [.target(name: "WordCount")]
        ),
    ]
)
