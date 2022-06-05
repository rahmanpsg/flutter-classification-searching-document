import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/file_data_model.dart';
import 'package:stacked/stacked.dart';

class TableViewModel extends BaseViewModel {
  final log = getLogger('TableViewModel');

  FileDataModel? _file;
  FileDataModel? get file => _file;

  void setFile(FileDataModel? file) {
    _file = file;
    notifyListeners();
  }
}
