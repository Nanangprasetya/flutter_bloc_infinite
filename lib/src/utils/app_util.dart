import 'package:flutter/material.dart';

class AppUtil {
  static ImageProvider<Object> imageProvider(String? uri, {double scale = 1}) {
    if (uri != null) {
      return NetworkImage(uri, scale: scale);
    }
    return NetworkImage(
        "https://biscuit.my.id/wp-content/uploads/2021/09/PP-Image-2-min.png",
        scale: scale);
  }
}
