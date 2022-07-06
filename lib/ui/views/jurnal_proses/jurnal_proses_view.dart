import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/views/table/models/column_item.dart';
import 'package:pencarian_jurnal/ui/views/table/table_view.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_card.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_chip.dart';
import 'package:stacked/stacked.dart';

import 'jurnal_proses_viewmodel.dart';

class JurnalProsesView extends StatelessWidget {
  const JurnalProsesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JurnalProsesViewModel>.reactive(
      viewModelBuilder: () => JurnalProsesViewModel(),
      onModelReady: (model) => model.init(),
      builder: (
        BuildContext context,
        JurnalProsesViewModel model,
        Widget? child,
      ) {
        int no = 1;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                Flexible(
                  child: CustomCard(
                    title: 'Proses Jurnal',
                    child: Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Row(
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: model.back,
                                  child: const Icon(
                                    Ionicons.arrow_back,
                                    color: secondaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Proses jurnal menggunakan metode TF-IDF dan K-NN',
                                style: boldTextStyle.copyWith(
                                  fontSize: 16,
                                  color: secondaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ExpandedTile(
                                      enabled: !model.busy('calculateTFIDF'),
                                      controller: model.expandedTileController,
                                      theme: const ExpandedTileThemeData(
                                        headerColor: secondaryColor,
                                        headerRadius: 24.0,
                                        contentBackgroundColor: Colors.white,
                                      ),
                                      title: Text(
                                        'Hasil Metode TF-IDF',
                                        style: boldTextStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      trailing: model.busy('calculateTFIDF')
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : const Icon(Icons.chevron_right),
                                      content: model.busy('calculateTFIDF')
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Column(
                                              children: [
                                                DropdownSearch<String>(
                                                  items: model.jurnals
                                                      .map((jurnal) => jurnal)
                                                      .toList(),
                                                  selectedItem: model.jurnals[
                                                      model.selectedIndex],
                                                  onChanged: (val) {
                                                    model.setSelectedIndex(model
                                                        .jurnals
                                                        .indexOf(val!));
                                                  },
                                                ),
                                                // SizedBox(
                                                //   height: 40,
                                                //   child: ListView.separated(
                                                //     controller:
                                                //         model.scrollController,
                                                //     physics:
                                                //         const ClampingScrollPhysics(),
                                                //     scrollDirection:
                                                //         Axis.horizontal,
                                                //     shrinkWrap: true,
                                                //     itemBuilder: ((_, index) =>
                                                //         CustomChip(
                                                //             text:
                                                //                 'Jurnal ${index + 1}',
                                                //             textColor:
                                                //                 Colors.white,
                                                //             color: secondaryColor,
                                                //             onTap: () => model
                                                //                 .setSelectedIndex(
                                                //                     index),
                                                //             isActive: model
                                                //                     .selectedIndex ==
                                                //                 index)),
                                                //     separatorBuilder: (_,
                                                //             index) =>
                                                //         const SizedBox(width: 15),
                                                //     itemCount:
                                                //         model.hasils.length,
                                                //   ),
                                                // ),
                                                Card(
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  elevation: 0,
                                                  child: SizedBox(
                                                    height: 550,
                                                    child: TableView(
                                                      showDropzone: false,
                                                      columns: [
                                                        ColumnItem(
                                                            value: "NO",
                                                            width: 60),
                                                        ColumnItem(
                                                            value: "KATA",
                                                            width: 200),
                                                        ColumnItem(
                                                            value:
                                                                "TOTAL KEMUNCULAN",
                                                            width: 200),
                                                        ColumnItem(
                                                            value: "TF",
                                                            width: 200),
                                                        ColumnItem(
                                                            value: "IDF",
                                                            width: 200),
                                                        ColumnItem(
                                                            value: "TD-IDF",
                                                            width: 200),
                                                      ],
                                                      rows: model.hasils[model
                                                              .selectedIndex]
                                                          .map(
                                                            (hasil) => TableRow(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 60,
                                                                    child: Text(
                                                                        "${no++}"),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 200,
                                                                    child: Text(
                                                                      hasil
                                                                          .keyword,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 200,
                                                                    child: Text(
                                                                      hasil
                                                                          .count
                                                                          .toString(),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 200,
                                                                    child: Text(
                                                                      hasil.tf
                                                                          .toString(),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 200,
                                                                    child: Text(
                                                                      hasil.idf
                                                                          .toString(),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 200,
                                                                    child: Text(
                                                                      hasil
                                                                          .tfIdf
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
                                              ],
                                            ),
                                    ),
                                    ExpandedTile(
                                      enabled: !model.busy('pengujianKNN'),
                                      controller: model.expandedTileController2,
                                      theme: const ExpandedTileThemeData(
                                        headerColor: secondaryColor,
                                        headerRadius: 24.0,
                                        contentBackgroundColor: Colors.white,
                                      ),
                                      title: Text(
                                        'Pengujian Metode K-NN',
                                        style: boldTextStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      trailing: model.busy('pengujianKNN')
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : const Icon(Icons.chevron_right),
                                      content: model.busy('pengujianKNN')
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : DefaultTabController(
                                              initialIndex: 0,
                                              length: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const ListTile(
                                                    dense: true,
                                                    selected: true,
                                                    selectedColor:
                                                        secondaryColor,
                                                    leading: Icon(Ionicons
                                                        .information_circle_outline),
                                                    title: Text(
                                                      'Pengujian dengan membagi data 80:20 (80% data training dan 20% data testing) dari daftar jurnal',
                                                    ),
                                                  ),
                                                  TabBar(
                                                    labelColor: secondaryColor,
                                                    labelStyle: boldTextStyle
                                                        .copyWith(fontSize: 18),
                                                    indicatorColor:
                                                        secondaryColor,
                                                    onTap: (index) {
                                                      model.hasilPengujianTabIndex =
                                                          index;

                                                      model.notifyListeners();
                                                    },
                                                    tabs: const <Widget>[
                                                      Tab(
                                                        text:
                                                            'Classification Report',
                                                      ),
                                                      Tab(
                                                        text:
                                                            'Daftar Jurnal Pengujian',
                                                      ),
                                                    ],
                                                  ),
                                                  IndexedStack(
                                                    index: model
                                                        .hasilPengujianTabIndex,
                                                    children: const [
                                                      ClassificationReportTable(),
                                                      HasilPengujianJurnalTable()
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ClassificationReportTable extends ViewModelWidget<JurnalProsesViewModel> {
  const ClassificationReportTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, JurnalProsesViewModel viewModel) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      child: SizedBox(
        height: 550,
        child: TableView(
          showDropzone: false,
          columns: [
            ColumnItem(value: "NO", width: 60),
            ColumnItem(value: "KATEGORI", width: 300),
            ColumnItem(value: "PRECISION", width: 200),
            ColumnItem(value: "RECALL", width: 200),
            ColumnItem(value: "F1-SCORE", width: 200),
            ColumnItem(value: "SUPPORT", width: 100),
          ],
          rows: [
            ...viewModel.hasilTraining.classificationReports
                .asMap()
                .entries
                .map(
              (entry) {
                if (entry.value.kategori == 'macro avg' ||
                    entry.value.kategori == 'weighted avg') {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: secondaryColor,
                          ),
                          height: 15,
                          width: 60,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: 300,
                          child: Text(
                            entry.value.kategori.toUpperCase(),
                            style: boldTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            entry.value.precision.toString(),
                            style: boldTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            entry.value.recall.toString(),
                            style: boldTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            entry.value.f1Score.toString(),
                            style: boldTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: 100,
                          child: Text(
                            entry.value.support.toString(),
                            style: boldTextStyle,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: 60,
                        child: Text("${entry.key + 1}"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          entry.value.kategori,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          entry.value.precision.toString(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          entry.value.recall.toString(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          entry.value.f1Score.toString(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          entry.value.support.toString(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: secondaryColor,
                  ),
                  height: 15,
                  width: 750,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 100,
                  child: Text(
                    'SCORE',
                    style: boldTextStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    viewModel.hasilTraining.score.toString(),
                    style: boldTextStyle,
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class HasilPengujianJurnalTable extends ViewModelWidget<JurnalProsesViewModel> {
  const HasilPengujianJurnalTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, JurnalProsesViewModel viewModel) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      child: SizedBox(
        height: 550,
        child: TableView(
          showDropzone: false,
          columns: [
            ColumnItem(value: "NO", width: 30),
            ColumnItem(value: "FILE", width: 310),
            ColumnItem(value: "PENULIS", width: 250),
            ColumnItem(value: "TAHUN", width: 80),
            ColumnItem(value: "PRODI", width: 200),
            ColumnItem(value: "PREDIKSI", width: 200),
          ],
          rows: viewModel.hasilTraining.data.asMap().entries.map((entry) {
            return TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 30,
                  child: Text("${entry.key + 1}"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 310,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => viewModel.toPDFView(entry.value),
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
                      const SizedBox(width: 8),
                      Expanded(child: Text(entry.value.fileData?.name ?? '')),
                      const SizedBox(width: 8),
                      Text(
                        entry.value.fileData?.size ?? '',
                        style: greyTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: greyThirdColor,
                        child: Text(
                          entry.value.nama!.trim()[0].toUpperCase(),
                          style: greyTextStyle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(entry.value.nama ?? ''),
                          const SizedBox(height: 4),
                          Text(
                            entry.value.nim ?? '',
                            style: greyTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 80,
                  child: Text(entry.value.tahun ?? ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 200,
                  child: Text(entry.value.prodi ?? ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 200,
                  child: Text(entry.value.prediksi ?? ''),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
