import Foundation

guard let inputUrl = Bundle.module.url(forResource: "input", withExtension: "txt") else {
  fatalError("Input resource not found")
}

guard let input = try? String.init(contentsOf: inputUrl) else {
  fatalError("Input is not a string")
}
