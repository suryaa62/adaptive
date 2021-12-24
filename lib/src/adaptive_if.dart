import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:adaptive/adaptive.dart';

T AdaptiveIfPlatform<T>(
    {required BuildContext context,
    required T ifNotSpecified,
    T? ifWeb,
    T? ifIos,
    T? ifMacos,
    T? ifAndroid,
    T? ifLinux,
    T? ifWindows}) {
  AdaptiveData adaptiveData = AdaptiveData.of(context);
  PlatformIs platformIs = adaptiveData.platform;

  if ((ifWeb != null) && platformIs == PlatformIs.web) return ifWeb;
  if (platformIs == PlatformIs.android && ifAndroid != null) {
    return ifAndroid;
  } else if (platformIs == PlatformIs.ios && ifIos != null) {
    return ifIos;
  } else if (platformIs == PlatformIs.macos && ifMacos != null) {
    return ifMacos;
  } else if (platformIs == PlatformIs.windows && ifWindows != null) {
    return ifWindows;
  } else if (platformIs == PlatformIs.linux && ifLinux != null) {
    return ifLinux;
  }

  return ifNotSpecified;
}

T AdaptiveIfScreen<T>({
  required BuildContext context,
  required T ifNotSpecified,
  T? ifSmall,
  T? ifLarge,
  T? ifMedium,
}) {
  ScreenSize screenSize = calculateCurrentScreenSize(context);
  if (screenSize == ScreenSize.isSmall && ifSmall != null) return ifSmall;
  if (screenSize == ScreenSize.isMedium && ifMedium != null) return ifMedium;
  if (screenSize == ScreenSize.isLarge && ifLarge != null) return ifLarge;
  return ifNotSpecified;
}

T AdaptiveIf<T>({
  required BuildContext context,
  required T ifNotSpecified,
  T? ifWebSmall,
  T? ifWebMedium,
  T? ifWebLarge,
  T? ifIosSmall,
  T? ifIosMedium,
  T? ifIosLarge,
  T? ifMacosSmall,
  T? ifMacosMedium,
  T? ifMacosLarge,
  T? ifAndroidSmall,
  T? ifAndroidMedium,
  T? ifAndroidLarge,
  T? ifLinuxSmall,
  T? ifLinuxMedium,
  T? ifLinuxLarge,
  T? ifWindowsSmall,
  T? ifWindowsMedium,
  T? ifWindowsLarge,
}) {
  return AdaptiveIfPlatform<T>(
    context: context,
    ifNotSpecified: ifNotSpecified,
    ifWeb: AdaptiveIfScreen<T>(
        context: context,
        ifNotSpecified:
            ifWebSmall ?? ifWebMedium ?? ifWebLarge ?? ifNotSpecified,
        ifLarge: ifWebLarge,
        ifMedium: ifWebMedium,
        ifSmall: ifWebSmall),
    ifIos: AdaptiveIfScreen<T>(
        context: context,
        ifNotSpecified:
            ifIosSmall ?? ifIosMedium ?? ifIosLarge ?? ifNotSpecified,
        ifLarge: ifIosLarge,
        ifMedium: ifIosMedium,
        ifSmall: ifIosSmall),
    ifLinux: AdaptiveIfScreen<T>(
        context: context,
        ifNotSpecified:
            ifLinuxSmall ?? ifLinuxMedium ?? ifLinuxLarge ?? ifNotSpecified,
        ifLarge: ifLinuxLarge,
        ifMedium: ifLinuxMedium,
        ifSmall: ifLinuxSmall),
    ifWindows: AdaptiveIfScreen<T>(
        context: context,
        ifNotSpecified: ifWindowsSmall ??
            ifWindowsMedium ??
            ifWindowsLarge ??
            ifNotSpecified,
        ifLarge: ifWindowsLarge,
        ifMedium: ifWindowsMedium,
        ifSmall: ifWindowsSmall),
    ifMacos: AdaptiveIfScreen<T>(
        context: context,
        ifNotSpecified:
            ifMacosSmall ?? ifMacosMedium ?? ifMacosLarge ?? ifNotSpecified,
        ifLarge: ifMacosLarge,
        ifMedium: ifMacosMedium,
        ifSmall: ifMacosSmall),
    ifAndroid: AdaptiveIfScreen<T>(
        context: context,
        ifNotSpecified: ifAndroidSmall ??
            ifAndroidMedium ??
            ifAndroidLarge ??
            ifNotSpecified,
        ifLarge: ifAndroidLarge,
        ifMedium: ifAndroidMedium,
        ifSmall: ifAndroidSmall),
  );
}
