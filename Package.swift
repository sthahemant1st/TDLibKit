// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
// DO NOT EDIT! Generated automatically. See scripts/swift_package_generator.py

import PackageDescription

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/Swiftgram/TDLibFramework", .exact("1.8.53-bdec6af5")),

]
let tdLibDependency: Target.Dependency = .product(name: "TDLibFramework", package: "TDLibFramework")
#else
let dependencies: [Package.Dependency] = []
let tdLibDependency: Target.Dependency = "CTDLib"
#endif

let package = Package(
    name: "TDLibKit",
    platforms: [
        // Following versions of https://github.com/Swiftgram/TDLibFramework/blob/main/Package.swift
        .iOS(.v12),
        .macOS(.v10_15),
        .watchOS(.v4),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "TDLibKit",
            targets: ["TDLibKit"]),
    ],
    dependencies: dependencies,
    targets: [
        .systemLibrary(
            name: "CTDLib",
            pkgConfig: "tdjson",
            providers: [
                // Note: TDLib must be built from source on most Linux systems
                // See: https://github.com/tdlib/td#building
                .apt(["libtd-dev"])
            ]
        ),
        .target(
            name: "TDLibKit",
            dependencies: [tdLibDependency]
        ),
        .testTarget(
            name: "TDLibKitTests",
            dependencies: ["TDLibKit"]
        ),
    ]
)

