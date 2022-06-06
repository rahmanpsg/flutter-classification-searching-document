import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/ui/views/table/models/column_item.dart';
import 'package:pencarian_jurnal/ui/views/table/table_viewmodel.dart';
import 'package:stacked/stacked.dart';

class Header extends ViewModelWidget<TableViewModel> {
  final List<ColumnItem> columns;

  const Header({
    Key? key,
    required this.columns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, TableViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns.map((column) {
          return SizedBox(
            width: column.width,
            child: Text(
              column.value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
