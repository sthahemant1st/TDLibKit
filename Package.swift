// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
// DO NOT EDIT! Generated automatically. See scripts/swift_package_generator.py

import PackageDescription



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
    dependencies: [
    ],
    targets: [
        .target(
            name: "TDLibKit",
            
            linkerSettings: [
                // Link against the TDLib JSON library
                .unsafeFlags([
                    "-Ltdlib/lib",
                    "-ltdjson",
                    // Add runtime library search path so macOS can find libtdjson.dylib
                    "-Xlinker", "-rpath", "-Xlinker", "tdlib/lib"
                ])
            ]
        ),
        .testTarget(
            name: "TDLibKitTests",
            dependencies: ["TDLibKit"]
        ),
    ]
)

