import argparse


def get_file_content(tdlibframework_version):
    return f"""// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
// DO NOT EDIT! Generated automatically. See scripts/swift_package_generator.py

import PackageDescription

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
let dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/Swiftgram/TDLibFramework", .exact("{tdlibframework_version}")),
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

"""


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "tdlibframework_version", help="Swiftgram/TDLibFramework version"
    )

    args = parser.parse_args()
    with open("Package.swift", "w") as f:
        f.write(get_file_content(args.tdlibframework_version))
