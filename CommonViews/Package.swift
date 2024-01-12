// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonViews",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CommonViews",
            targets: ["CommonViews"]),
    ],
    dependencies: [
        .package(name: "Common", path: "../Common"),
        .package(url: "https://github.com/pointfreeco/swiftui-navigation.git", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "CommonViews",
            dependencies: [
                .product(name: "Common", package: "Common"),
                .product(name: "SwiftUINavigation", package: "swiftui-navigation")
            ]
        ),
        .testTarget(
            name: "CommonViewsTests",
            dependencies: ["CommonViews"]),
    ]
)
