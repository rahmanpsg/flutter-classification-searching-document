import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_button.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: greySecondaryColor,
              width: 1,
            ),
          ),
          child: Column(
            children: <Widget>[
              _Header(columns: columns),
              const Divider(color: greySecondaryColor, thickness: 1),
              if (rows != null) ...[
                const SizedBox(height: 8),
                SizedBox(
                  height: 70.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: rows!.length,
                    itemBuilder: (_, index) =>
                        _Row(children: rows![index].children!),
                    separatorBuilder: (_, index) =>
                        const Divider(color: greySecondaryColor, thickness: 1),
                  ),
                )
              ],
              const _Footer(),
            ],
          ),
        ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
      padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: greySecondaryColor,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ElevatedButton.icon(
            onPressed: null,
            icon: const Icon(Ionicons.arrow_back),
            label: const Text("Sebelumnya"),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text("1"),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor.withOpacity(.1),
                  minimumSize: Size(45, 45),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text("2"),
                style: TextButton.styleFrom(
                  // backgroundColor: primaryColor.withOpacity(.1),
                  minimumSize: Size(45, 45),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text("3"),
                style: TextButton.styleFrom(
                  // backgroundColor: primaryColor.withOpacity(.1),
                  minimumSize: Size(45, 45),
                ),
              ),
              // TextButton(onPressed: () {}, child: Text("2")),
              // TextButton(onPressed: () {}, child: Text("3")),
              // const Text(". . .", style: primaryTextStyle),
              // TextButton(onPressed: () {}, child: Text("8")),
              // TextButton(onPressed: () {}, child: Text("9")),
              // TextButton(onPressed: () {}, child: Text("10")),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Ionicons.arrow_forward,
                color: primaryColor,
              ),
              label: const Text(
                "Selanjutnya",
                style: primaryTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
