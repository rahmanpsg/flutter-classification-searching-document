import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/enums/dialog_type.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_textfield.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.form: (context, sheetRequest, completer) =>
        _FormDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _FormDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _FormDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  State<_FormDialog> createState() => __FormDialogState();
}

class __FormDialogState extends State<_FormDialog> {
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    JurnalModel jurnal = widget.request.data as JurnalModel;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.request.title ?? "",
                style: extraBoldTextStyle.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Silahkan lengkapi data berikut",
                style: italicTextStyle,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Nama Penulis',
                onChanged: (value) => jurnal.nama = value,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: 'NIM',
                onChanged: (value) => jurnal.nim = value,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: 'Tahun',
                onChanged: (value) => jurnal.tahun = value,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: 'Prodi',
                onChanged: (value) => jurnal.prodi = value,
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Ionicons.alert_circle,
                      color: dangerColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      errorMessage!,
                      style: dangerTextStyle,
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Ionicons.close),
                      label: const Text('Batal'),
                      onPressed: () {
                        widget.completer(
                          DialogResponse(
                            confirmed: false,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: dangerColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Ionicons.save),
                      label: const Text('Simpan'),
                      onPressed: () {
                        setState(() {
                          errorMessage = "Semua data harus diisi";
                        });
                        // widget.completer(
                        //   DialogResponse(
                        //     confirmed: true,
                        //   ),
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
