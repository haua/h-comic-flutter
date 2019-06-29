import 'dart:io';
import 'dart:developer' as developer;

class Logger {
  static void log () {
    stderr.writeln('print me');
  }

  static void log2() {
    developer.log('打印了没', name: 'my.app.category');

    developer.log('打印了没 1', name: 'my.other.category');
    developer.log('打印了没 2', name: 'my.other.category');
  }
}




