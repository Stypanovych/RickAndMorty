// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "InfoLogger", path: "../InfoLogger"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.1"),
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                .product(name: "InfoLogger", package: "InfoLogger"),
                .product(name: "Domain", package: "Domain"),
                .product(name: "Alamofire", package: "Alamofire"),
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: [
                "Data",
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "Domain", package: "Domain")
            ]
        ),
    ]
)
