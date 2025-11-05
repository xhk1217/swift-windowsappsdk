// swift-tools-version: 5.10

import PackageDescription

let linkerSettings: [LinkerSetting] = [
/* Figure out magic incantation so we can delay load these dlls
    .unsafeFlags(["-L\(currentDirectory)/Sources/CWinAppSDK/nuget/lib"]),
    .unsafeFlags(["-Xlinker" , "/DELAYLOAD:Microsoft.WindowsAppRuntime.Bootstrap.dll"]),
*/
]

let package = Package(
    name: "swift-windowsappsdk",
    products: [
        .library(name: "WinAppSDK", type: .static, targets: ["WinAppSDK"]),
        .library(name: "CWinAppSDK", targets: ["CWinAppSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rayman-zhao/swift-cwinrt", branch: "main"),
        .package(url: "https://github.com/rayman-zhao/swift-windowsfoundation", branch: "main"),
        .package(url: "https://github.com/xhk1217/swift-uwp", branch: "main"),
    ],
    targets: [
        .target(
            name: "WinAppSDK",
            dependencies: [
                .product(name: "CWinRT", package: "swift-cwinrt"),
                .product(name: "WindowsFoundation", package: "swift-windowsfoundation"),
                .product(name: "UWP", package: "swift-uwp"),
                "CWinAppSDK"
            ]
        ),
        .target(
            name: "CWinAppSDK",
            resources: [
                .copy("nuget/bin/Microsoft.WindowsAppRuntime.Bootstrap.dll"),
            ],
            linkerSettings: linkerSettings
        ),
    ]
)
