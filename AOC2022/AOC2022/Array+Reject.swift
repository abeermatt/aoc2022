import Foundation

extension Array {
    
    func reject(_ isRejected: (Element) throws -> Bool) rethrows -> [Element] {
        return try self
            .filter {
                return try !isRejected($0)
            }
    }
}

