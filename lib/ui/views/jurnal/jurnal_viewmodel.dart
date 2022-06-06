import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/views/table/models/column_item.dart';
import 'package:stacked/stacked.dart';

class JurnalViewModel extends BaseViewModel {
  final List<ColumnItem> tableColumns = [
    ColumnItem(value: "No", width: 60),
    ColumnItem(value: "File", width: 250),
    ColumnItem(value: "Penulis", width: 270),
    ColumnItem(value: "Tahun", width: 100),
    ColumnItem(value: "Kategori", width: 200),
    ColumnItem(value: "Status", width: 200),
    ColumnItem(value: "Aksi", width: 150),
  ];

  late final List<TableRow> tableRows;

  void init() {
    tableRows = List.generate(
      1000,
      (index) => TableRow(
        children: [
          SizedBox(
            width: tableColumns[0].width,
            child: Text("${index + 1}"),
          ),
          SizedBox(
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
                Text("Jurnal_${index + 1}"),
                const SizedBox(width: 8),
                const Text(
                  "4MB",
                  style: greyTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
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
                  children: const <Widget>[
                    Text("Abd. Rahman"),
                    SizedBox(height: 4),
                    Text(
                      "214280187",
                      style: greyTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: tableColumns[3].width, child: Text("2022")),
          SizedBox(width: tableColumns[4].width, child: Text("Informatika")),
          SizedBox(width: tableColumns[5].width, child: Text("Informatika")),
          SizedBox(
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
          )
        ],
      ),
    );
  }
}
