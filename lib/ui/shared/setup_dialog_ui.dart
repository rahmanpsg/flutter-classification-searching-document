import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/enums/dialog_type.dart';
import 'package:pencarian_jurnal/ui/shared/form_dialog/form_dialog_view.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.form: (context, sheetRequest, completer) =>
        FormDialogView(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
