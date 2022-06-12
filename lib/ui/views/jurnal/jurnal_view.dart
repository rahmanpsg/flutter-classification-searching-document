import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/views/table/table_view.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_card.dart';
import 'package:stacked/stacked.dart';

import 'jurnal_viewmodel.dart';

class JurnalView extends StatelessWidget {
  const JurnalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JurnalViewModel>.reactive(
      viewModelBuilder: () => JurnalViewModel(),
      builder: (
        BuildContext context,
        JurnalViewModel model,
        Widget? child,
      ) {
        int no = 1;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                child: CustomCard(
                  title: "Daftar Jurnal",
                  subtitle: "Silahkan tambahkan jurnal baru",
                  childExpanded: true,
                  child: TableView(
                    columns: model.tableColumns,
                    rows: model.jurnals
                        .map(
                          (jurnal) => TableRow(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SizedBox(
                                  width: model.tableColumns[0].width,
                                  child: Text("${no++}"),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SizedBox(
                                  width: model.tableColumns[1].width,
                                  child: Row(
                                    children: [
                                      GestureDetector(
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
                                      const SizedBox(width: 8),
                                      Expanded(
                                          child: Text(
                                              jurnal.fileData?.name ?? '')),
                                      const SizedBox(width: 8),
                                      Text(
                                        jurnal.fileData?.size ?? '',
                                        style: greyTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SizedBox(
                                  width: model.tableColumns[2].width,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: greyThirdColor,
                                        child: Text(
                                          jurnal.nama!
                                              .split(' ')
                                              .map((e) => e[0])
                                              .join(),
                                          style: greyTextStyle,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(jurnal.nama ?? ''),
                                          const SizedBox(height: 4),
                                          Text(
                                            jurnal.nim ?? '',
                                            style: greyTextStyle,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SizedBox(
                                  width: model.tableColumns[3].width,
                                  child: Text(jurnal.tahun ?? ''),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SizedBox(
                                  width: model.tableColumns[4].width,
                                  child: Text(jurnal.prodi ?? ''),
                                ),
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 8),
                              //   child: SizedBox(
                              //       width: model.tableColumns[5].width,
                              //       child: Text("Informatika")),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SizedBox(
                                  width: model.tableColumns[5].width,
                                  child: Row(
                                    children: <Widget>[
                                      Tooltip(
                                        message: "Download",
                                        child: IconButton(
                                          icon: const Icon(
                                            Ionicons.download,
                                            color: secondaryColor,
                                          ),
                                          onPressed: () =>
                                              model.onDownloadTap(jurnal),
                                        ),
                                      ),
                                      Tooltip(
                                        message: "Ubah",
                                        child: IconButton(
                                          icon: const Icon(
                                            Ionicons.create,
                                            color: thirdColor,
                                          ),
                                          onPressed: () =>
                                              model.onEditTap(jurnal),
                                        ),
                                      ),
                                      Tooltip(
                                        message: "Hapus",
                                        child: IconButton(
                                          icon: const Icon(
                                            Ionicons.trash,
                                            color: dangerColor,
                                          ),
                                          onPressed: () =>
                                              model.onDeleteTap(jurnal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
