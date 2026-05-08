import 'package:flutter/widgets.dart';

import 'app_store.dart';

class AppScope extends InheritedNotifier<SonnenkompassStore> {
  const AppScope({
    required SonnenkompassStore store,
    required super.child,
    super.key,
  }) : super(notifier: store);

  static SonnenkompassStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope found in context');
    return scope!.notifier!;
  }
}
