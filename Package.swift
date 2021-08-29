// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mocito",
    products: [
        .library(
            name: "Mocito",
            targets: ["Mocito"]
        )
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "Mocito",
            dependencies: []
        ),
        .testTarget(
            name: "MocitoTests",
            dependencies: ["Mocito"]
        )
    ]
)
