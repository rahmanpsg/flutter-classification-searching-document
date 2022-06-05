import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/ui/views/table/table_viewmodel.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked/stacked.dart';

class Footer extends ViewModelWidget<TableViewModel> {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, TableViewModel model) {
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
            colM: 4,
            colS: 4,
            child: OutlinedButton.icon(
              onPressed: null,
              icon: const Icon(Ionicons.arrow_back),
              label: const Text("Sebelumnya"),
            ),
          ),
          Div(
            colL: 8,
            colM: 4,
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
            colM: 4,
            colS: 4,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Ionicons.arrow_forward),
                label: const Text("Selanjutnya"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
