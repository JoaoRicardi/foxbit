import 'package:flutter_test/flutter_test.dart';
import 'package:foxbit_hiring_test_template/src/app/widgets/list/currency/controller/currency_controller.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_details.dart';
import 'package:foxbit_hiring_test_template/src/domain/repositories/currency/currency_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/utils.dart';

main() {
  setUpAll(() {
    TestUtils.setUpAllTests();
  });

  late CurrencyController currencyController;

  test('Detail controller test with value', () {
    final ICurrencyRepository _repository = TestUtils.instanceOf();
    currencyController = CurrencyController(_repository);
    when(() => _repository.getCurrencyDetail(1))
        .thenAnswer((invocation) => Stream.fromIterable([
      CurrencyDetail(
        100.0, 101.0, 102.0
      )
    ]));

    currencyController.stream.listen((event) {
      expect(event.lastValue, 100.0);
      expect(event.sessionOpen, 101.0);
      expect(event.sessionClose, 102.0);
    });

    currencyController.init(1);
  });

}
