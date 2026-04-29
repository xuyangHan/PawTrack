// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PawTrack",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "PawTrack", targets: ["PawTrack"])
    ],
    targets: [
        .target(
            name: "PawTrack",
            path: "PawTrack"
        ),
        .testTarget(
            name: "PawTrackTests",
            dependencies: ["PawTrack"],
            path: "PawTrackTests"
        )
    ]
)
