import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_card.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_dropzone.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';

import 'klasifikasi_viewmodel.dart';

class KlasifikasiView extends StatelessWidget {
  const KlasifikasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<KlasifikasiViewModel>.reactive(
      viewModelBuilder: () => KlasifikasiViewModel(),
      builder: (
        BuildContext context,
        KlasifikasiViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  CustomCard(
                    title: "Klasifikasi",
                    subtitle:
                        "Silahkan pilih jurnal yang ingin anda klasifikasikan",
                    child: Column(
                      children: [
                        CustomDropZone(
                          onDroppedFile: model.setFileData,
                          isDroppedShow: true,
                          height: 150,
                        ),
                        const SizedBox(height: 16),
                        if (model.errorFileMessage != null) ...[
                          Text(
                            model.errorFileMessage!,
                            style:
                                primaryTextStyle.copyWith(color: dangerColor),
                          ),
                          const SizedBox(height: 16),
                        ],
                        CustomTextField(
                          controller: model.kController,
                          errorText: model.errorKMessage,
                          hintText: 'Masukkan nilai K [3, 5, 7, 9]',
                          prefixIcon: const Icon(Ionicons.reader_outline),
                          suffixIcon: const Tooltip(
                            message:
                                'K adalah jumlah tetangga terdekat dari metode KNN',
                            child: Icon(Ionicons.information_circle),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 200),
                          child: OutlinedButton.icon(
                            onPressed: model.isBusy ? null : model.onSubmit,
                            icon: model.isBusy
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ))
                                : const Icon(Ionicons.send),
                            label: const Text('Proses'),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (model.result != null)
                    CustomCard(
                      title: 'Hasil Klasifikasi',
                      child: Card(
                        elevation: 0,
                        child: ListView.separated(
                          itemBuilder: ((context, index) {
                            final jurnal = model.result![index];

                            return ListTile(
                              tileColor: thirdColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              leading: GestureDetector(
                                onTap: () => model.toPDFView(jurnal),
                                child: Tooltip(
                                  message: "Lihat",
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Card(
                                      child: Image.network(
                                        "https://img.icons8.com/external-flatart-icons-flat-flatarticons/64/undefined/external-pdf-file-online-learning-flatart-icons-flat-flatarticons.png",
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                jurnal.nama ?? '-',
                                style: boldTextStyle,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Prodi: ${jurnal.prodi}',
                                  ),
                                  Text(
                                    'Jarak: ${jurnal.jarak}',
                                  ),
                                ],
                              ),
                            );
                          }),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemCount: model.result!.length,
                          shrinkWrap: true,
                        ),
                      ),
                    )
                ],
              )),
        );
      },
    );
  }
}
