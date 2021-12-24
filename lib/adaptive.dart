library adaptive;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum PlatformIs {
  android,
  ios,
  windows,
  macos,
  linux,
  unknown,
  web,
}

class AdaptiveData extends InheritedWidget {
  AdaptiveData(
      {Key? key,
      required Widget child,
      this.smallScreenBreakpoint = 480,
      this.mediumScreenBreakpoint = 768,
      this.largeScreenBreakpoint = 1024})
      : super(key: key, child: child) {
    if (kIsWeb) {
      _platform = PlatformIs.web;
    } else if (Platform.isAndroid) {
      _platform = PlatformIs.android;
    } else if (Platform.isIOS) {
      _platform = PlatformIs.ios;
    } else if (Platform.isMacOS) {
      _platform = PlatformIs.macos;
    } else if (Platform.isWindows) {
      _platform = PlatformIs.windows;
    } else if (Platform.isLinux) {
      _platform = PlatformIs.linux;
    } else {
      _platform = PlatformIs.unknown;
    }
  }

  final double smallScreenBreakpoint;
  final double mediumScreenBreakpoint;
  final double largeScreenBreakpoint;
  late PlatformIs _platform;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static AdaptiveData of(BuildContext context) {
    final AdaptiveData? result =
        context.dependOnInheritedWidgetOfExactType<AdaptiveData>();
    assert(result != null, 'No AdaptiveData found in context');
    return result!;
  }
}

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
  PlatformIs platformIs = adaptiveData._platform;

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

enum ScreenSize {
  isMedium,
  isSmall,
  isLarge,
}

ScreenSize calculateCurrentScreenSize(BuildContext context) {
  AdaptiveData adaptiveData = AdaptiveData.of(context);
  double currentScreenSize = MediaQuery.of(context).size.width;
  if (currentScreenSize < adaptiveData.smallScreenBreakpoint)
    return ScreenSize.isSmall;
  if (currentScreenSize < adaptiveData.mediumScreenBreakpoint)
    return ScreenSize.isMedium;
  return ScreenSize.isLarge;
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
