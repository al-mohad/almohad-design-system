import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLogger {
  static bool _isEnabled = kDebugMode; // Default: Enabled in debug mode
  static Set<LogType> _logLevels = {
    LogType.info,
    LogType.warning,
    LogType.danger,
    LogType.error,
    LogType.success,
    LogType.debug,
  };

  // ANSI color codes for console output (for better readability)
  static const String _reset = '\x1B[0m';
  static const String _blue = '\x1B[34m'; // Info
  static const String _yellow = '\x1B[33m'; // Warning
  static const String _red = '\x1B[31m'; // Error/Danger
  static const String _green = '\x1B[32m'; // Success
  static const String _magenta = '\x1B[35m'; // Debug

  /// Initializes the logger (optional customization)
  static void initialize({
    bool isEnabled = kDebugMode,
    Set<LogType>? allowedLevels,
  }) {
    _isEnabled = isEnabled;
    if (allowedLevels != null) {
      _logLevels = allowedLevels;
    }
  }

  /// Main log function
  AppLogger(String message, {LogType type = LogType.debug, Object? metadata}) {
    _log(type, message, metadata);
  }

  /// Private log function that handles filtering and formatting
  static void _log(LogType type, String message, Object? metadata) {
    if (!_isEnabled || !_logLevels.contains(type)) return;

    final String color = _getColor(type);
    final String logHeader = '$color[${type.name.toUpperCase()}] $_reset';

    // Append metadata if provided
    if (metadata != null) {
      message += ' | Metadata: ${metadata.toString()}';
    }

    // Handle long messages by chunking them
    const int chunkSize = 800; // Adjust chunk size as needed
    if (message.length > chunkSize) {
      for (int i = 0; i < message.length; i += chunkSize) {
        log(
          '$logHeader ${message.substring(i, i + chunkSize > message.length ? message.length : i + chunkSize)}',
        );
      }
    } else {
      log('$logHeader $message');
    }
  }

  /// Returns ANSI color for log type
  static String _getColor(LogType type) {
    switch (type) {
      case LogType.info:
        return _blue;
      case LogType.warning:
        return _yellow;
      case LogType.danger:
        return _red;
      case LogType.error:
        return _red;
      case LogType.success:
        return _green;
      case LogType.debug:
        return _magenta;
    }
  }
}

/// Enum for log levels to allow filtering
enum LogType { info, warning, danger, error, success, debug }
