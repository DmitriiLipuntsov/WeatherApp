//
//  LoggerManager.swift
//  Vocal Remover
//
//  Created by Dmitry Lipuntsov on 21.07.2023.
//

import Foundation
import os.log

class LoggerManager {
    static let shared = LoggerManager()
    
    private init() { }
    
    func log(
        subsystem: Subsystem,
        level: LogLevel,
        destination: String,
        message: String
    ) {
        let logFormat = "%@ %@"
        let logLevelString = level.rawValue
        let arg = logLevelString + destination + message
        let logMessage = String(format: logFormat, arg, "")
        os_log("%{public}@", log: subsystem.log, type: level.osLogType, logMessage)
    }
}

extension LoggerManager {
    enum Subsystem: String {
        case layout
        case remoteData
        case localData
        case data
        
        var log: OSLog {
            return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "", category: self.rawValue)
        }
    }
}

extension LoggerManager {
    enum LogLevel: String {
        case info    = "[ℹ️] Info:    -------- \n"
        case debug   = "[🛠️] Debug:   -------- \n"
        case warning = "[⚠️] Warning: -------- \n"
        case error   = "[🔥] Error:   -------- \n"
        
        var osLogType: OSLogType {
            if #available(iOS 14.0, *) {
                switch self {
                case .info:
                    return .info
                case .debug, .warning:
                    return .debug
                case .error:
                    return .error
                }
            } else {
                switch self {
                case .info, .debug, .warning:
                    return .default
                case .error:
                    return .error
                }
            }
        }
    }
}
