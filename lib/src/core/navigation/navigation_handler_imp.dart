import 'package:flutter/material.dart';
import 'package:foxbit_hiring_test_template/src/core/navigation/navigation_handler.dart';


class NavigationHandlerImp implements INavigationHandler {

  @override
  GlobalKey<NavigatorState> appGlobalKey = GlobalKey();

  @override
  Route appRoutes(RouteSettings settings) {
    switch (settings.name) {


      default:
        //em caso de rota desconhecida
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return Container();
          },
        );
    }
  }

  @override
  pop<T extends Object?>([T? result]) async {
    return appGlobalKey.currentState?.pop(T);
  }

  @override
  Future<T?> push<T extends Object?>(String route, {Object? arguments}) async {
    return appGlobalKey.currentState?.pushNamed(route, arguments: arguments);
  }

  @override
  BuildContext getContext() {
    return appGlobalKey.currentState!.context;
  }

  @override
  Future<T?>? pushReplacement<T extends Object?>(String route,
      {Object? arguments}) {
    return appGlobalKey.currentState
        ?.pushReplacementNamed(route, result: arguments);
  }
}
