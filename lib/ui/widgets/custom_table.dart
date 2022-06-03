import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_textfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:responsive_ui/responsive_ui.dart';

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
      mainAxisSize: MainAxisSize.min,
      children: [
        const _Toolbar(),
        const SizedBox(height: 12),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              border: Border.all(
                color: greySecondaryColor,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _Header(columns: columns),
                const Divider(color: greySecondaryColor, thickness: 1),
                if (rows != null)
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 10,
                      // itemCount: rows!.length,
                      itemBuilder: (_, index) => _Row(
                        children: rows![index].children!,
                      ),
                      separatorBuilder: (_, index) => const Divider(
                        color: greySecondaryColor,
                        thickness: 1,
                      ),
                    ),
                  ),
                const _Footer(),
              ],
            ),
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
    return Container(
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30.w,
            child: const CustomTextField(
              hintText: "Cari jurnal",
              prefixIcon: Icon(
                Ionicons.search,
                color: primaryColor,
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Ionicons.add),
            label: const Text("Tambah"),
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          // Text("Lihat"),
          // const SizedBox(width: 8),
          // Icon(Icons.arrow_drop_down),
        ],
      ),
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
      child: Responsive(
        crossAxisAlignment: WrapCrossAlignment.start,
        runSpacing: 16,
        children: <Widget>[
          Div(
            colL: 2,
            colS: 4,
            child: ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(Ionicons.arrow_back),
              label: const Text("Sebelumnya"),
            ),
          ),
          Div(
            colL: 8,
            colS: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
          ),
          Div(
            colL: 2,
            colS: 4,
            child: Directionality(
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
          ),
        ],
      ),
    );
  }
}
