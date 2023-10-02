import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

enum BlogSource {
  devTo,
  medium,
  hashNode,
}

extension EnumEx on BlogSource {
  String getName() {
    switch (this) {
      case BlogSource.devTo:
        return 'dev.to';
      case BlogSource.medium:
        return 'medium';
      case BlogSource.hashNode:
        return 'hashnode';
      default:
        return 'unknown';
    }
  }

  String getLogo() {
    switch (this) {
      case BlogSource.devTo:
        return Assets.images.devDotTo.path;
      case BlogSource.medium:
        return Assets.images.medium.path;
      case BlogSource.hashNode:
        return Assets.images.hashnode.path;
      default:
        return 'unknown';
    }
  }
}

final ValueNotifier<BlogSource> blogSource =
    ValueNotifier<BlogSource>(BlogSource.devTo);
