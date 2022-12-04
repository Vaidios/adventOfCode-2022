import Foundation

guard let inputUrl = Bundle.module.url(forResource: "input", withExtension: "txt") else {
  fatalError("Input resource not found")
}

guard let input = try? String.init(contentsOf: inputUrl) else {
  fatalError("Input is not a string")
}

let splitInput = input.split(separator: "\n")

var containedCount: Int = 0
var overlappedCount: Int = 0

for element in splitInput {
  
  let splitElement = element.split(separator: ",")
  
  let pairA = splitElement[0].split(separator: "-").map({ Int($0) }).compactMap({ $0 })
  let pairB = splitElement[1].split(separator: "-").map({ Int($0) }).compactMap({ $0 })
  
  let a = (pairA[0] ... pairA[1])
  let b = (pairB[0] ... pairB[1])
  
  if a.overlaps(b) || b.overlaps(a) {
    overlappedCount += 1
  }
  
  if a.lowerBound <= b.lowerBound && a.upperBound >= b.upperBound {
    containedCount += 1
    continue
  }
  
  if b.lowerBound <= a.lowerBound && b.upperBound >= a.upperBound {
    containedCount += 1
  }
}

print("Part 1")
print("Sum of contained in itself assignments is \(containedCount)")
print("")

print("Part 2")
print("Sum of overlapped assignments is \(overlappedCount)")
print("")
