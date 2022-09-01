import 'package:flutter_test/flutter_test.dart';
import 'package:foxbit_hiring_test_template/src/app/modules/home/controller/home_controller.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_item.dart';
import 'package:foxbit_hiring_test_template/src/domain/repositories/currency/currency_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/utils.dart';

main() {
  setUpAll(() {
    TestUtils.setUpAllTests();
  });

  late HomeController homeController;

  test('Home controller test with itens', () {
    final ICurrencyRepository _repository = TestUtils.instanceOf();
    homeController = HomeController(_repository);
    when(() => _repository.getAvailableCurrencies())
        .thenAnswer((invocation) => Stream.fromIterable([
              [CurrencyModel(omsId: 0, instrumentId: 1, symbol: "BTC"),CurrencyModel(omsId: 1, instrumentId: 2, symbol: "ETH")]
            ]));

    homeController.stream.listen((event) {
      expect(event.length, 2);
      expect(event[0].symbol, 'BTC');
      expect(event[1].symbol, 'ETH');
    });

    homeController.init();
  });

  test('Home controller test with empty list', () {
    final ICurrencyRepository _repository = TestUtils.instanceOf();
    homeController = HomeController(_repository);
    when(() => _repository.getAvailableCurrencies())
        .thenAnswer((invocation) => Stream.empty());

    homeController.stream.listen((event) {
      expect(event.length, 0);
      expect(event.isEmpty, true);
    });

    homeController.init();
  });
}
