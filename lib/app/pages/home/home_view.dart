import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_hiring_test_template/app/pages/home/home_controller.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends ViewState<HomePage, HomeController> {
  HomePageState() : super(HomeController());

  @override
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(
      title: const Text('Home Screen'),
    ),
    body: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return StreamBuilder<Map<dynamic, dynamic>>(
            stream: controller.ws.stream.asBroadcastStream(),
            initialData: {},
            builder: (context, snapshot){
              return Text(snapshot.data.toString());
            }
          );
        }
    ),
  );
}
