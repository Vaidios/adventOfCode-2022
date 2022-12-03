import Foundation

guard let inputUrl = Bundle.module.url(forResource: "input", withExtension: "txt") else {
  fatalError("Input resource not found")
}

guard let input = try? String.init(contentsOf: inputUrl) else {
  fatalError("Input is not a string")
}

let output = input.split(separator: "\n", omittingEmptySubsequences: false)

var seperateColumns: [[Int]] = [[]]
var column: [Int] = []

for substring in output {
  
  if substring.isEmpty {
    seperateColumns.append(column)
    column = []
  } else {
    guard let integerValue = Int(substring) else {
      fatalError("Non-integer value")
    }
    column.append(integerValue)
  }
}

let reducedSortedValues: [Int] = seperateColumns.compactMap({ $0.reduce(0, +) }).sorted(by: >)

guard let partOneResult = reducedSortedValues.first else { fatalError("No result available") }

print("Part 1")
print("Elf with biggest ammount of calories has \(partOneResult) calories")
print("")

let partTwoResult = (0..<3).map({ reducedSortedValues[$0] }).reduce(0, +)
print("Part 2")
print("Top three elves carry \(partTwoResult) calories")
print("")
