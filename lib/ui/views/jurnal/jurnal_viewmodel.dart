import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/views/table/models/column_item.dart';
import 'package:stacked/stacked.dart';

class JurnalViewModel extends BaseViewModel {
  final List<ColumnItem> tableColumns = [
    ColumnItem(value: "No", width: 100),
    ColumnItem(value: "File", width: 200),
    ColumnItem(value: "Penulis", width: 100),
    ColumnItem(value: "Kategori", width: 100),
    ColumnItem(value: "Status", width: 100),
    ColumnItem(value: "Aksi", width: 100),
  ];

  final List<TableRow> tableRows = List.generate(
    100,
    (index) => TableRow(
      children: [
        Text("${index + 1}"),
        // Text("Jurnal ${index + 1}"),
        Row(
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
            Text(
              "4MB",
              style: greyTextStyle,
            ),
          ],
        ),
        Row(
          children: [
            CircleAvatar(
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
                const Text("Abd. Rahman"),
                const SizedBox(height: 4),
                Text(
                  "214280187",
                  style: greyTextStyle,
                ),
              ],
            ),
          ],
        ),
        Text("Informatika"),
        Text("Informatika"),
        Row(
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
        )
      ],
    ),
  );
}
