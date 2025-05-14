import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    colors: kIsWeb ? false : !Platform.isIOS,
    printEmojis: true,
  ),
);
