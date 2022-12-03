import Foundation

guard let inputUrl = Bundle.module.url(forResource: "input", withExtension: "txt") else {
  fatalError("Input resource not found")
}

guard let input = try? String.init(contentsOf: inputUrl) else {
  fatalError("Input is not a string")
}

let alphabet = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z"
]

let splitInput = input.split(separator: "\n", omittingEmptySubsequences: false)

func priority(for char: Character) -> Int {
  guard let index = alphabet.firstIndex(of: char.lowercased()) else {
    fatalError("Invalid character in sequence")
  }
  let priority = char.isUppercase ? index + 27 : index + 1

  return priority
}

var partOneSumOfPriorites: Int = 0

for line in splitInput {
  guard line.count % 2 == 0 else { fatalError("Non even amount of elements") }
  let firstPart = line.prefix(line.count / 2)
  var secondPart = line.suffix(line.count / 2)
  
  for character in firstPart {
    if secondPart.contains(character) {
      secondPart.removeAll(where: { $0 == character })
      let priority = priority(for: character)
      partOneSumOfPriorites += priority
    }
  }
}

var partTwoSumOfPriorites: Int = 0

let numberOfGroups = splitInput.count / 3
for i in (0 ..< numberOfGroups) {
  let index = i * 3
  let first = splitInput[index]
  let second = splitInput[index + 1]
  let third = splitInput[index + 2]

  for char in first {
    if second.contains(char) && third.contains(char) {
      let priority = priority(for: char)
      partTwoSumOfPriorites += priority
      break
    }
  }
}

print("Part 1")
print("Sum of priorites is \(partOneSumOfPriorites)")
print("")

print("Part 2")
print("Sum of priorites is \(partTwoSumOfPriorites)")
print("")
