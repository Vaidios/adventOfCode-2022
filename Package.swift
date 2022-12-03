// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let day1 = "Day1"
let day2 = "Day2"

let package = Package(
    name: "Advent of code",
    products: [
      .executable(name: day1, targets: [day1]),
      .executable(name: day2, targets: [day2]),
    ],
    dependencies: [

    ],
    targets: [
      .target(name: day1, resources: [.process("Resources")]),
      .target(name: day2, resources: [.process("Resources")]),
    ]
)
