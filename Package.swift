// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let days = [
  "Day1",
  "Day2",
  "Day3",
  "Day4",
  "Day5",
  "Day6",
  "Day7",
]

let resources: [Resource] = [.process("Resources")]

let package = Package(
    name: "Advent of code",
    products: days.map({ Product.executable(name: $0, targets: [$0]) }),
    dependencies: [ ],
    targets: days.map({ Target.executableTarget(name: $0, resources: resources) })
)
