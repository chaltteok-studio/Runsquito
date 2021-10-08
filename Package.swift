// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Runsquito",
    defaultLocalization: "en",
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
        .package(url: "https://github.com/wlsdms0122/JSToast", .exact("1.0.0"))
    ],
    targets: [
        .target(
            name: "Runsquito",
            dependencies: []
        ),
        .target(
            name: "RunsquitoKit",
            dependencies: [
                "Runsquito",
                "JSToast"
            ]
        ),
        .testTarget(
            name: "RunsquitoTests",
            dependencies: ["Runsquito"]
        )
    ]
)
