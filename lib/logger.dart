import 'dart:io';

import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(methodCount: 0, colors: !Platform.isIOS, printEmojis: true),
);
