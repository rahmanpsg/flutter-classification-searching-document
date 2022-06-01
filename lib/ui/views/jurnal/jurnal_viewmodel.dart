import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class JurnalViewModel extends BaseViewModel {
  final List<String> tableColumns = const [
    "No",
    "Judul",
    "Kategori",
    "Tanggal",
  ];

  final List<TableRow> tableRows = List.generate(
    100,
    (index) => TableRow(
      children: [
        Text("${index + 1}"),
        Text("Jurnal ${index + 1}"),
        Text("Kategori ${index + 1}"),
        Text("2020-01-01"),
      ],
    ),
  );
}
