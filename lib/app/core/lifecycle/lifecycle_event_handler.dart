import 'package:flutter/widgets.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final Future<void> Function()? detachedCallBack;
  final Future<void> Function()? inactiveCallBack;

  LifecycleEventHandler({this.detachedCallBack, this.inactiveCallBack});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        if (detachedCallBack != null) detachedCallBack!();
        break;
      case AppLifecycleState.inactive:
        if (inactiveCallBack != null) inactiveCallBack!();
        break;
      default:
        break;
    }
  }
}
