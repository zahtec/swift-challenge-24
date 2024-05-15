
// MARK: Allow for easy substringing of any string utilizing the `index` method
public extension String {
	func sub(index: Int) -> Character {
		let charIndex = self.index(self.startIndex, offsetBy: index)
		return self[charIndex]
	}

	func sub(range: Range<Int>) -> Substring {
		let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
		let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
		return self[startIndex ..< stopIndex]
	}
}
