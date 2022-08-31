import 'package:flutter/material.dart';

import 'dependencie_injection/dependencie_injection_mock.dart';
import 'params/params_mocks.dart';

class TestUtils {

  static final _diHandler = DIMock();
  static final _paramsHnadler = ParamsMock();


  static setUpAllTests(){
    _diHandler.registerMocks();
    _paramsHnadler.registerAllMockParams();
  }

  static Widget buildTestableWidget({
    required Widget widget,
  }) =>
      MaterialApp(
          home: Scaffold(
        body: widget,
      ));


  static T instanceOf<T extends Object>({String? instanceName}){
    return _diHandler.getIt<T>(instanceName: instanceName);
  }
}
