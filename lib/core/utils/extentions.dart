import 'package:flutter/material.dart';

extension MediaSize on BuildContext {
  Size get() {
    return MediaQuery.of(this).size;
  }

  bool isWeb() {
    return get().width > 420;
  }
}
