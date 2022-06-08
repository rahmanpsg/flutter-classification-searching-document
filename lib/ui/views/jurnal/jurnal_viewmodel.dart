import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/services/jurnal_service.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/views/table/models/column_item.dart';
import 'package:stacked/stacked.dart';

class JurnalViewModel extends BaseViewModel {
  final log = getLogger('JurnalViewModel');

  final JurnalService _jurnalService = locator<JurnalService>();

  final List<JurnalModel> _jurnals = locator<JurnalService>().jurnals;

  final List<ColumnItem> tableColumns = [
    ColumnItem(value: "No", width: 60),
    ColumnItem(value: "File", width: 250),
    ColumnItem(value: "Penulis", width: 250),
    ColumnItem(value: "Tahun", width: 100),
    ColumnItem(value: "Kategori", width: 150),
    ColumnItem(value: "Status", width: 150),
    ColumnItem(value: "Aksi", width: 150),
  ];

  late final List<TableRow> tableRows;

  void init() {
    tableRows = List.generate(
      _jurnals.length,
      (index) => TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: tableColumns[0].width,
              child: Text("${index + 1}"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: tableColumns[1].width,
              child: Row(
                children: [
                  Card(
                    child: Image.network(
                      "https://img.icons8.com/external-flatart-icons-flat-flatarticons/64/undefined/external-pdf-file-online-learning-flatart-icons-flat-flatarticons.png",
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(child: Text(_jurnals[index].fileData?.name ?? '')),
                  const SizedBox(width: 8),
                  Text(
                    _jurnals[index].fileData?.size ?? '',
                    style: greyTextStyle,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: tableColumns[2].width,
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: greyThirdColor,
                    child: Text(
                      "AR",
                      style: greyTextStyle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_jurnals[index].nama ?? ''),
                      const SizedBox(height: 4),
                      Text(
                        _jurnals[index].nim ?? '',
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
              width: tableColumns[3].width,
              child: Text(_jurnals[index].tahun ?? ''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: tableColumns[4].width,
              child: Text(_jurnals[index].prodi ?? ''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
                width: tableColumns[5].width, child: Text("Informatika")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: tableColumns[6].width,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Ionicons.download,
                      color: secondaryColor,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Ionicons.trash,
                      color: dangerColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
