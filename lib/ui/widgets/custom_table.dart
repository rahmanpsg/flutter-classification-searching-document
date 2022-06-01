import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';

class CustomTable extends StatelessWidget {
  final List<String> columns;
  final List<TableRow>? rows;

  const CustomTable({
    Key? key,
    required this.columns,
    this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _Header(columns: columns),
        if (rows != null) ...[
          const SizedBox(height: 8),
          ...rows!
              .map(
                (row) => _Row(
                  children: row.children!,
                ),
              )
              .toList(),
        ],
      ],
    );
  }
}

class _Toolbar extends StatelessWidget {
  const _Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("Lihat"),
        const SizedBox(width: 8),
        Icon(Icons.arrow_drop_down),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.columns,
  }) : super(key: key);

  final List<String> columns;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: columns.map((column) {
          return Text(
            column,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final List<Widget> children;

  const _Row({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          color: greyThirdColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
