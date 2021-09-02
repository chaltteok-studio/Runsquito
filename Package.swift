// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Runsquito",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "Runsquito",
            targets: ["Runsquito"]
        ),
        .library(
            name: "RunsquitoKit",
            targets: ["RunsquitoKit"]
        )
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "Runsquito",
            dependencies: []
        ),
        .target(
            name: "RunsquitoKit",
            dependencies: ["Runsquito"]
        ),
        .testTarget(
            name: "RunsquitoTests",
            dependencies: ["Runsquito"]
        )
    ]
)
