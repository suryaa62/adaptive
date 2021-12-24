import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:adaptic/adaptive.dart';

VoidCallback AdaptivePlatformVoidCallback(
    {required BuildContext context,
    required VoidCallback ifNotSpecified,
    VoidCallback? ifWeb,
    VoidCallback? ifIos,
    VoidCallback? ifMacos,
    VoidCallback? ifAndroid,
    VoidCallback? ifLinux,
    VoidCallback? ifWindows}) {
  return AdaptiveIfPlatform<VoidCallback>(
      context: context,
      ifNotSpecified: ifNotSpecified,
      ifWeb: ifWeb,
      ifAndroid: ifAndroid,
      ifIos: ifIos,
      ifLinux: ifLinux,
      ifMacos: ifMacos,
      ifWindows: ifWindows);
}

VoidCallback AdaptiveScreenVoidCallback({
  required BuildContext context,
  required VoidCallback ifNotSpecified,
  VoidCallback? ifSmall,
  VoidCallback? ifLarge,
  VoidCallback? ifMedium,
}) {
  return AdaptiveIfScreen<VoidCallback>(
      context: context,
      ifNotSpecified: ifNotSpecified,
      ifLarge: ifLarge,
      ifMedium: ifMedium,
      ifSmall: ifSmall);
}
