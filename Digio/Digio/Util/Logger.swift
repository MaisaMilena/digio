public protocol Logger: AnyObject {
    static func info(_ message: String, file: StaticString, function: StaticString)
    static func event(_ message: String, file: StaticString, function: StaticString)
    static func error(_ message: String, file: StaticString, function: StaticString)
}
