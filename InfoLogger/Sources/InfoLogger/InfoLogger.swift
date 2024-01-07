// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit

// MARK: - Logger

public struct InfoLogger {

    // MARK: - Config

    struct Config {

        let dateFormatter: DateFormatter
        let showDateInfo: Bool
        let showFileInfo: Bool
        let showFunctionInfo: Bool
        let logLevels: [LogLevel]
    }

    // MARK: - LogLevel

    public enum LogLevel: CaseIterable {

        case verbose
        case debug
        case info
        case warning
        case error

        // MARK: Fileprivate

        fileprivate var indicator: String {
            switch self {
            case .verbose: return "◽️"
            case .debug: return "◾️"
            case .info: return "🔷"
            case .warning: return "⚠️"
            case .error: return "❌"
            }
        }
    }

    // MARK: Internal

    public static let shared = InfoLogger()

    var config: Config
    let isEnabled = true

    public static func log<T>(
        _ level: LogLevel,
        _ value: T,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        let result = shared.log(level, error: value as? NSError, message: "\(value)", function: function, file: file, line: line)
        NSLog(result)
    }

    // MARK: Private

    private init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd HH:mm:ss.SSS"

        let config = Config(
            dateFormatter: dateFormatter,
            showDateInfo: true,
            showFileInfo: true,
            showFunctionInfo: true,
            logLevels: LogLevel.allCases
        )

        self.init(config: config)
    }

    private init(config: Config) {
        self.config = config
    }

    @discardableResult private func log(
        _ level: LogLevel,
        error: NSError?,
        message: String,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) -> String {
        var dateTime = String()
        if config.showFileInfo {
            dateTime = "\(config.dateFormatter.string(from: Date())) "
        }

        let levelString = "\(level.indicator) "

        var fileLine = String()
        if config.showFileInfo {
            fileLine = "[\((file as NSString).lastPathComponent):\(line)]"
        }

        var functionString = String()
        if config.showFunctionInfo {
            functionString = function
        }

        let infoString = "\(dateTime)\(levelString)\(fileLine) \(functionString)".trimmingCharacters(in: .whitespaces)
        let logString = "\(infoString) → \(message)"

        return logString
    }
}
