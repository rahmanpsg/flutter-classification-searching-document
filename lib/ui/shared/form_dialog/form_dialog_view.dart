import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/enums/form_dialog_type.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'form_dialog_viewmodel.dart';

class FormDialogData {
  final FormDialogType type;
  final JurnalModel jurnal;

  FormDialogData({
    required this.type,
    required this.jurnal,
  });
}

class FormDialogView extends StatelessWidget {
  final DialogRequest<FormDialogData> request;
  final Function(DialogResponse) completer;

  const FormDialogView(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FormDialogViewModel>.reactive(
      viewModelBuilder: () => FormDialogViewModel(),
      onModelReady: (model) => model.init(completer, request.data!),
      builder: (
        BuildContext context,
        FormDialogViewModel model,
        Widget? child,
      ) {
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
                    request.title ?? "",
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
                    controller: model.namaController,
                    prefixIcon: const Icon(
                      Ionicons.person_outline,
                      color: secondaryColor,
                    ),
                    hintText: 'Nama Penulis',
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: model.nimController,
                    prefixIcon: const Icon(
                      Ionicons.pricetag_outline,
                      color: secondaryColor,
                    ),
                    hintText: 'NIM',
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: model.tahunController,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (contex) {
                            return AlertDialog(
                              title: const Text('Pilih Tahun'),
                              content: SizedBox(
                                  width: 300,
                                  child: YearPicker(
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                    selectedDate: model.jurnal.tahun != null
                                        ? DateTime(
                                            int.parse(model.jurnal.tahun!))
                                        : DateTime.now(),
                                    onChanged: (dateTime) {
                                      model.tahunController.text =
                                          dateTime.year.toString();
                                      model.jurnal.tahun =
                                          dateTime.year.toString();

                                      Navigator.of(context).pop();
                                    },
                                  )),
                            );
                          });
                    },
                    prefixIcon: const Icon(
                      Ionicons.calendar_outline,
                      color: secondaryColor,
                    ),
                    readOnly: true,
                    hintText: 'Tahun',
                    onChanged: (value) => model.jurnal.tahun = value,
                  ),
                  // const SizedBox(height: 8),
                  // CustomTextField(
                  //   controller: model.prodiController,
                  //   onTap: () {
                  //     DropDownState(
                  //       DropDown(
                  //         searchHintText: 'Cari',
                  //         bottomSheetTitle: 'Prodi',
                  //         searchBackgroundColor: Colors.black12,
                  //         dataList: model.prodis
                  //             .map(
                  //               (prodi) => SelectedListItem(
                  //                   false, "${prodi.fakultas} - ${prodi.nama}"),
                  //             )
                  //             .toList(),
                  //         selectedItem: (String selected) {
                  //           model.prodiController.text =
                  //               selected.split(' - ')[1];
                  //         },
                  //         enableMultipleSelection: false,
                  //         searchController: model.searchController,
                  //       ),
                  //     ).showModal(context);
                  //   },
                  //   readOnly: true,
                  //   prefixIcon: const Icon(
                  //     Ionicons.school_outline,
                  //     color: secondaryColor,
                  //   ),
                  //   suffixIcon: const Icon(Ionicons.caret_down),
                  //   hintText: 'Prodi',
                  // ),
                  if (model.errorMessage != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Ionicons.alert_circle,
                          color: dangerColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          model.errorMessage!,
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
                          onPressed: model.isBusy
                              ? null
                              : () {
                                  completer(
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
                          icon: model.isBusy
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : const Icon(Ionicons.save),
                          label: Text(request.data?.type == FormDialogType.add
                              ? 'Simpan'
                              : 'Ubah'),
                          onPressed: model.isBusy ? null : model.onSubmit,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
