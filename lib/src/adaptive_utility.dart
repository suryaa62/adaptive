import 'package:flutter/widgets.dart';
import 'package:adaptive/adaptive.dart';

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
