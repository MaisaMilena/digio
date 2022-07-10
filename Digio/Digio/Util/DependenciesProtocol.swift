import Dispatch

public protocol HasMainQueue {
    var mainQueue: DispatchQueue { get }
}
