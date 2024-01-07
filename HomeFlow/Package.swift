// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeFlow",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "HomeFlow",
            targets: ["HomeFlow"]),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "Data", path: "../Data"),
        .package(name: "Common", path: "../Common"),
        .package(url: "https://github.com/pointfreeco/swiftui-navigation.git", from: "1.2.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "HomeFlow",
            dependencies: [
                .product(name: "Domain", package: "Domain"),
                .product(name: "Data", package: "Data"),
                .product(name: "Common", package: "Common"),
                .product(name: "SwiftUINavigation", package: "swiftui-navigation"),
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")
            ]
        ),
        .testTarget(
            name: "HomeFlowTests",
            dependencies: [
                "HomeFlow",
                .product(name: "Domain", package: "Domain")
            ]
        ),
    ]
)
