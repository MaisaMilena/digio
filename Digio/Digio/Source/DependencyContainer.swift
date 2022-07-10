import Foundation

typealias Dependencies = HasMainQueue

extension DispatchQueue {
    func async(execute work: @escaping () -> Void) {
        async(group: nil, execute: work)
    }
}

final class DependencieContainer: Dependencies {
    lazy var mainQueue = DispatchQueue.main
}
