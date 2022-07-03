import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:stacked/stacked.dart';

class TableService with ReactiveServiceMixin {
  final log = getLogger('TableService');

  // final ReactiveValue<bool> update = ReactiveValue(false);

  // TableService() {
  //   listenToReactiveValues([update]);
  // }

  void updateData() {
    notifyListeners();
  }
}
