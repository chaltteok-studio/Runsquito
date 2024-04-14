// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Runsquito",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "Runsquito",
            targets: ["Runsquito"]
        )
    ],
    targets: [
        .target(
            name: "Runsquito",
            dependencies: []
        ),
        .testTarget(
            name: "RunsquitoTests",
            dependencies: ["Runsquito"]
        )
    ]
)
