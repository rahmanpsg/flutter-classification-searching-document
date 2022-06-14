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
                                ? const CircularProgressIndicator()
                                : const Icon(Ionicons.send),
                            label: const Text('Proses'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
