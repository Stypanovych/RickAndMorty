// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Common",
            targets: ["Common"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swiftui-navigation.git", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "Common",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "swiftui-navigation")
            ]
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: ["Common"]),
    ]
)
