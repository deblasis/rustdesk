import 'package:flutter_hbb/consts.dart';
import 'package:flutter_hbb/common.dart'; // for SessionID typedef
import 'package:flutter_hbb/models/platform_model.dart'; // for bind
import 'package:flutter_hbb/generated_bridge.dart'
    if (dart.library.html) 'package:flutter_hbb/web/bridge.dart';

/// Clamp custom scale percent to supported bounds.
int clampCustomScalePercent(int percent) {
  if (percent < 5) return 5;
  if (percent > 1000) return 1000;
  return percent;
}

/// Parse a string percent and clamp. Defaults to 100 when invalid.
int parseCustomScalePercent(String? s, {int defaultPercent = 100}) {
  final parsed = int.tryParse(s ?? '') ?? defaultPercent;
  return clampCustomScalePercent(parsed);
}

/// Convert a percent value to scale factor after clamping.
double percentToScale(int percent) => clampCustomScalePercent(percent) / 100.0;

/// Fetch, parse and clamp the custom scale percent for a session.
Future<int> getSessionCustomScalePercent(SessionID sessionId) async {
  final opt = await bind.sessionGetFlutterOption(
      sessionId: sessionId, k: kCustomScalePercentKey);
  return parseCustomScalePercent(opt);
}

/// Fetch and compute the custom scale factor for a session.
Future<double> getSessionCustomScale(SessionID sessionId) async {
  final p = await getSessionCustomScalePercent(sessionId);
  return percentToScale(p);
}
