import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/views/table/models/column_item.dart';
import 'package:pencarian_jurnal/ui/views/table/table_view.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_card.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_textfield.dart';
import 'package:stacked/stacked.dart';

import 'pencarian_viewmodel.dart';

class PencarianView extends StatelessWidget {
  const PencarianView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PencarianViewModel>.reactive(
      viewModelBuilder: () => PencarianViewModel(),
      builder: (
        BuildContext context,
        PencarianViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomCard(
                    title: 'Pencarian',
                    subtitle:
                        'Pencarian jurnal berdasarkan kata kunci yang dicari',
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: model.kataController,
                          errorText: model.errorKataMessage,
                          hintText: 'Kata kunci',
                          maxLines: 8,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: model.kController,
                          errorText: model.errorKMessage,
                          hintText: 'Masukkan nilai K',
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
                            label: const Text('Cari'),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (model.result != null)
                    CustomCard(
                      title: 'Hasil Pencarian',
                      subtitle: model.isBusy
                          ? null
                          : 'Waktu pencarian: ${model.duration}',
                      child: model.isBusy
                          ? const Center(child: CircularProgressIndicator())
                          : Card(
                              elevation: 0,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: ((context, index) {
                                  final jurnal = model.result![index];

                                  return ExpandedTile(
                                    controller: ExpandedTileController(),
                                    theme: const ExpandedTileThemeData(
                                      headerColor: thirdColor,
                                      headerRadius: 24.0,
                                      contentBackgroundColor: Colors.white,
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
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          jurnal.nama ?? '-',
                                          style: boldTextStyle.copyWith(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'Prodi: ${jurnal.prodi}',
                                          style: primaryTextStyle.copyWith(
                                              color: Colors.white),
                                        ),
                                        Text('Jarak: ${jurnal.jarak}',
                                            style: primaryTextStyle.copyWith(
                                                color: Colors.white)),
                                      ],
                                    ),
                                    content: Card(
                                      margin: const EdgeInsets.all(0),
                                      elevation: 0,
                                      child: SizedBox(
                                        height: 300,
                                        child: TableView(
                                          showDropzone: false,
                                          columns: [
                                            ColumnItem(value: "NO", width: 60),
                                            ColumnItem(
                                                value: "KATA", width: 200),
                                            ColumnItem(
                                                value: "TOTAL KEMUNCULAN",
                                                width: 200),
                                            ColumnItem(value: "TF", width: 200),
                                            ColumnItem(
                                                value: "IDF", width: 200),
                                            ColumnItem(
                                                value: "TF-IDF", width: 200),
                                          ],
                                          rows: jurnal.hasilsTfIdf
                                              ?.asMap()
                                              .entries
                                              .map(
                                                (hasil) => TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: SizedBox(
                                                        width: 60,
                                                        child: Text(
                                                            "${hasil.key + 1}"),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          hasil.value.keyword,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          hasil.value.count
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          hasil.value.tf
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          hasil.value.idf
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          hasil.value.tfIdf
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemCount: model.result!.length,
                                // shrinkWrap: true,
                              ),
                            ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
