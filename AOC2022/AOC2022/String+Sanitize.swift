import Foundation

extension String {
    
    func toLines() -> [String] {
        return
            self
            .split(separator: "\n")
            .reject(\.isEmpty)
            .map(String.init)
    }

}
