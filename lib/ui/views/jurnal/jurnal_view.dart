import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_card.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_table.dart';
import 'package:stacked/stacked.dart';

import 'jurnal_viewmodel.dart';

class JurnalView extends StatelessWidget {
  const JurnalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JurnalViewModel>.nonReactive(
      viewModelBuilder: () => JurnalViewModel(),
      builder: (
        BuildContext context,
        JurnalViewModel model,
        Widget? child,
      ) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: <Widget>[
              CustomCard(
                title: "Daftar Jurnal",
                subtitle: "Silahkan tambahkan jurnal baru",
                child: CustomTable(
                  columns: model.tableColumns,
                  rows: model.tableRows,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}