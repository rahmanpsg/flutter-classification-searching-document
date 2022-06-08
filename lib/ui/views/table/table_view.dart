import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_dropzone.dart';
import 'package:stacked/stacked.dart';

import 'models/column_item.dart';
import 'table_viewmodel.dart';
import 'widgets/header.dart';
import 'widgets/toolbar.dart';
import 'widgets/body.dart';

class TableView extends StatelessWidget {
  final List<ColumnItem> columns;
  final List<TableRow>? rows;

  const TableView({Key? key, required this.columns, this.rows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth =
        columns.map((column) => column.width).reduce((a, b) => a + b);

    return ViewModelBuilder<TableViewModel>.nonReactive(
      viewModelBuilder: () => TableViewModel(),
      onModelReady: (model) => model.init(),
      builder: (
        BuildContext context,
        TableViewModel model,
        Widget? child,
      ) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Toolbar(),
            const SizedBox(height: 12),
            CustomDropZone(onDroppedFile: model.setFile),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SingleChildScrollView(
                      controller: model.headerScrollController,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Header(
                        columns: columns,
                      ),
                    ),
                    const Divider(color: greySecondaryColor, thickness: 1),
                    if (rows != null)
                      Flexible(
                        child: SingleChildScrollView(
                          controller: model.bodyScrollController,
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: maxWidth + 130,
                            child: ListView.separated(
                              // shrinkWrap: true,
                              itemCount: rows!.length,
                              // itemCount: rows!.length,
                              itemBuilder: (_, index) => Body(
                                children: (rows![index].children!),
                              ),
                              separatorBuilder: (_, index) => const Divider(
                                color: greySecondaryColor,
                                thickness: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    // const _Footer(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
