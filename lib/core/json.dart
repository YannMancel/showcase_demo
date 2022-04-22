import 'dart:convert' as convert;

import 'package:flutter/services.dart';
import 'package:showcase_demo/_features.dart';

const kJsonKey = 'keys';

abstract class JsonInterface {
  const factory JsonInterface() = JsonFromAssets;

  Future<List<T>> readFromJson<T>({String key = kJsonKey});
}

class JsonFromAssets implements JsonInterface {
  const JsonFromAssets();

  @override
  Future<List<T>> readFromJson<T>({String key = kJsonKey}) async {
    final json = await rootBundle.loadString(Assets.json.tutorialKeys);
    final map = convert.jsonDecode(json);
    final keysOrNull = map[key] as List<dynamic>?;

    return keysOrNull != null ? keysOrNull.cast<T>() : List<T>.empty();
  }
}
