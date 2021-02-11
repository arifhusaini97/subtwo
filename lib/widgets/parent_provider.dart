import 'package:flutter/material.dart';

class ParentProviderQR extends InheritedWidget {
  final String theInfo;
  final Widget child;

  ParentProviderQR({this.theInfo, this.child}) : super(child: child);

  @override
  bool updateShouldNotify(ParentProviderQR oldWidget) {
    return true;
  }

  static ParentProviderQR of(BuildContext context) =>
      //context.inheritFromWidgetOfExactType(ParentProvider);
      context.dependOnInheritedWidgetOfExactType();
}
