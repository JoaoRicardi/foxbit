import 'package:flutter_test/flutter_test.dart';
import 'package:foxbit_hiring_test_template/src/core/data_soruce/web_socket.dart';

import '../../../utils/mock/data_source/socket_test.dart';
import '../../../utils/utils.dart';

main(){

  setUpAll((){
    TestUtils.setUpAllTests();
  });


  late TestFoxbitWebSocket foxbitSocket;

  test('Test basic method', () async {
    foxbitSocket = TestFoxbitWebSocket();


    var mockedResponse = { "m": 1, "i": 2, "n": "Test_method", "o": {}};

    foxbitSocket.send('TEST_METHOD', {});
    var res = await foxbitSocket.stream.first;

    expect(res.id, mockedResponse["i"]);
    expect(res.m, mockedResponse["m"]);
    expect(res.method, "Test_method");
    expect(res.data, mockedResponse["o"]);

    expect(foxbitSocket.streamController.isClosed, false);

    foxbitSocket.dispose();
    expect(foxbitSocket.streamController.isClosed, true);
    expect(() =>  foxbitSocket.send("ANOTHER_METHOD", {}), throwsA(isA<Exception>()));
  });
}