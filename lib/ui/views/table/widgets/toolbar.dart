import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/ui/views/table/table_viewmodel.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_textfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

class Toolbar extends ViewModelWidget<TableViewModel> {
  const Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TableViewModel model) {
    return SizedBox(
      width: 30.w,
      child: const CustomTextField(
        hintText: "Cari jurnal",
        prefixIcon: Icon(
          Ionicons.search,
          color: primaryColor,
        ),
      ),
    );
  }
}
