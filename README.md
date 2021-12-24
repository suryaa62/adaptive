<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Adaptive

This package provides set of widgets and functions which makes it easy and fast to write platform and screen adaptive code. By using this package you can avoid using if statements and MediaQuery for different platform and screen sizes.

## Features

* Developer can define thier own breakpoints in AdaptiveData widget.
* Generic functions to return values based on breakpoints or platform. 

## Getting started

* Simply install and import the package and start using.
* All functions require AdaptiveData widget above the tree.

## Usage

Add AdaptiveData anywhere above the tree.

```dart

Widget build(BuildContext context){
	return AdaptiveData(
		smallScreenBreakpoint: 480,
      		mediumScreenBreakpoint: 768,
      		largeScreenBreakpoint: 1024,
      		child: Scaffold( 
			body: Container()
			),
	);
}

```

Use functions anywhere below the AdaptiveData.

```dart

AdaptiveIfScreen<Widget>(
              context: context,
              ifNotSpecified: listView(), // if screen size is less than medium or small breakpoint then use this as 
              ifLarge: Row(
                children: [
                  Expanded(flex: 50, child: listView()),
                  Expanded(flex: 50, child: SampleItemDetailsView())
                ],
              ))),
    );

```

```dart

Center(
        child: Padding(
          padding: AdaptiveIfScreen(
              context: context,
              ifNotSpecified: EdgeInsets.all(10),
              ifLarge: EdgeInsets.all(20),
              ifMedium: EdgeInsets.all(15),
              ifSmall: EdgeInsets.all(10)),
          child: Text('More Information Here'),
        ),
      ),

```
## Functions

* AdaptiveIfScreen\<T> : To return screen size specific values.
* AdaptiveIfPlatform\<T> : To return platform specifice values.
* AdaptiveIf\<T> : Combination of AdaptiveIfScreen and AdaptiveIfPlatform.
* AdaptivePlatformVoidCallback : Returns platform specific voidCallback ( for example to provide deifferent onTap callback).
* AdaptiveScreenVoidCallback : Returnns screen size specifc voidCallback.

## Additional information

To raise issues , suggestions and ideas: https://github.com/suryaa62/adaptive
