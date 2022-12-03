// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let resources: [Resource] = [.process("Resources")]

let day1 = "Day1"
let day2 = "Day2"
let day3 = "Day3"
let day4 = "Day4"

let package = Package(
    name: "Advent of code",
    products: [
      .executable(name: day1, targets: [day1]),
      .executable(name: day2, targets: [day2]),
      .executable(name: day3, targets: [day3]),
      .executable(name: day4, targets: [day4]),
    ],
    dependencies: [

    ],
    targets: [
      .executableTarget(name: day1, resources: resources),
      .executableTarget(name: day2, resources: resources),
      .executableTarget(name: day3, resources: resources),
      .executableTarget(name: day4, resources: resources),
    ]
)
