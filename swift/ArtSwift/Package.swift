// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "ArtSwift",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "ArtSwift", targets: ["ArtSwift"]),
    ],
    dependencies: [
        .package(path: "../vendor/swift-log"),
    ],
    targets: [
        .target(
            name: "ArtSwift",
            dependencies: [.product(name: "Logging", package: "swift-log")]
        ),
        .testTarget(
            name: "ArtSwiftTests",
            dependencies: ["ArtSwift"]
        ),
    ]
)
