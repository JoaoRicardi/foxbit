import 'package:flutter/material.dart';
import 'package:foxbit_hiring_test_template/src/core/base/base_widget.dart';

class HomePage extends StatefulWidget {

  static const String route = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with FoxbitBaseWidget {


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
