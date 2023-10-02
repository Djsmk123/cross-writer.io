import 'dart:convert';

import 'package:blogtools/core/errors/exceptions.dart';
import 'package:blogtools/core/errors/failures.dart';

mixin JsonParsers {
  (Failure?, Map<String, dynamic>) parseJson(String json) {
    try {
      final data = jsonDecode(json);
      return (null, data);
    } catch (e) {
      return (JsonFailure(), {});
    }
  }
}

mixin Validation {
  bool isUrl(String value) {
    RegExp urlRegExp = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
      multiLine: false,
    );
    return urlRegExp.hasMatch(value);
  }
}
