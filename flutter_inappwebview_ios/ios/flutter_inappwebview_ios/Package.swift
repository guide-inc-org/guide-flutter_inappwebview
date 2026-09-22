// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "flutter_inappwebview_ios",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "flutter-inappwebview-ios", targets: ["flutter_inappwebview_ios"])
    ],
    dependencies: [
        .package(url: "https://github.com/Weebly/OrderedSet.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "flutter_inappwebview_ios",
            dependencies: [
                "OrderedSet"
            ],
            resources: [
                .process("Resources/PrivacyInfo.xcprivacy"),
                .copy("Storyboards")
            ]
        )
    ]
)
