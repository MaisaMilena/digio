import Foundation

final class Sentinel: Logger {
    static func info(
        _ message: String,
        file: StaticString = #file,
        function: StaticString = #function
    ) {
        log(level: "ℹ️", message: message, file: file, function: function)
    }
    
    static func event(
        _ message: String,
        file: StaticString = #file,
        function: StaticString = #function
    ) {
        log(level: "⏱", message: message, file: file, function: function)
    }
    
    static func error(
        _ message: String,
        file: StaticString = #file,
        function: StaticString = #function
    ) {
        log(level: "😱", message: message, file: file, function: function)
    }
    
    private static func log(
        level: String,
        message: String = "",
        file: StaticString = #file,
        function: StaticString = #function
    ) {
        let fileName = (String(describing: file) as NSString).lastPathComponent
        print("[\(level)] \(fileName) - \(function) -> \(message)")
    }
}
