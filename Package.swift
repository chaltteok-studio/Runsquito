// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mocito",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "Mocito",
            targets: ["Mocito"]
        ),
        .library(
            name: "MocitoKit",
            targets: ["MocitoKit"]
        )
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "Mocito",
            dependencies: []
        ),
        .target(
            name: "MocitoKit",
            dependencies: ["Mocito"]
        ),
        .testTarget(
            name: "MocitoTests",
            dependencies: ["Mocito"]
        )
    ]
)
