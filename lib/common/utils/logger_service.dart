import 'package:logger/logger.dart';

class LoggerService {
  static final Logger _logger = Logger();

  // Log an information message
  static void i(String message) {
    _logger.i(message);
  }

  // Log a warning message
  static void w(String message) {
    _logger.w(message);
  }

  // Log an error message
  static void e(String message) {
    _logger.e(message);
  }

  // Log a debug message
  static void d(String message) {
    _logger.d(message);
  }

  // Log a verbose message
  static void v(String message) {
    // ignore: deprecated_member_use
    _logger.v(message);
  }

  // Log a message with a specified log level
  static void log(Level level, String message) {
    _logger.log(level, message);
  }
}
