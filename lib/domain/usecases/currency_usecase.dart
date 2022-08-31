// import 'dart:async';
//
// import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
// import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';
// import 'package:foxbit_hiring_test_template/domain/repositories/currency_repository.dart';
//
// class CurrencyUseCase extends CompletableUseCase<CustomParams> {
//
//   CurrencyUseCase(this._repository);
//
//   final ICurrencyRepository _repository;
//
//   @override
//   Future<Stream<void>> buildUseCaseStream(CustomParams params) async {
//     final StreamController<void> controller = StreamController<void>();
//
//     try {
//       final Map _ = await _repository.getCurrencyDetail(params.socket, params.id);
//
//       controller.close();
//     } catch (e) {
//       controller.addError(e);
//     }
//
//     return controller.stream;
//   }
// }
//
// class CustomParams{
//   final int id;
//   final FoxbitWebSocket socket;
//
//   CustomParams(this.id, this.socket);
// }