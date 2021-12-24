import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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

  PlatformIs get platform => _platform;

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
