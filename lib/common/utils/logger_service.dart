import 'package:logger/logger.dart';

class LoggerService {
  static final Logger _logger = Logger();

  static void i(String message) {
    _logger.i(message);
  }

  static void w(String message) {
    _logger.w(message);
  }

  static void e(String message) {
    _logger.e(message);
  }

  static void d(String message) {
    _logger.d(message);
  }

  static void v(String message) {
    _logger.v(message);
  }

  static void log(Level level, String message) {
    _logger.log(level, message);
  }
}
