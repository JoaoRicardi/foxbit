import 'package:flutter/material.dart';
import 'package:foxbit_hiring_test_template/src/app/modules/home/home_page.dart';
import 'package:foxbit_hiring_test_template/src/core/base/base_widget.dart';
import 'package:foxbit_hiring_test_template/src/core/navigation/navigation_handler.dart';

class FoxbitApp extends StatelessWidget with FoxbitBaseWidget{

  FoxbitApp({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationHandler = di.get<INavigationHandler>();

    return MaterialApp(
      title: 'Flutter Demo For Foxbit',
      navigatorKey: navigationHandler.appGlobalKey,
      onGenerateRoute: navigationHandler.appRoutes,
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.route,
    );
  }
}
