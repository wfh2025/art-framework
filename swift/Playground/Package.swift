// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "Playground",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(path: "../ArtSwift"),
    ],
    targets: [
        .executableTarget(
            name: "Playground",
            dependencies: [.product(name: "ArtSwift", package: "ArtSwift")]
        ),
        .testTarget(
            name: "PlaygroundTests",
            dependencies: [.target(name: "Playground")]
        ),
    ]
)
