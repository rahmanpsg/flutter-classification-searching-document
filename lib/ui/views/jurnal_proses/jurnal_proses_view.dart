import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_card.dart';
import 'package:stacked/stacked.dart';

import 'jurnal_proses_viewmodel.dart';

class JurnalProsesView extends StatelessWidget {
  const JurnalProsesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JurnalProsesViewModel>.reactive(
      viewModelBuilder: () => JurnalProsesViewModel(),
      builder: (
        BuildContext context,
        JurnalProsesViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: CustomCard(
              title: 'Proses Jurnal',
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Row(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: model.back,
                            child: const Icon(
                              Ionicons.arrow_back,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Proses jurnal menggunakan metode TF-IDF dan K-NN',
                          style: boldTextStyle.copyWith(
                            fontSize: 16,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
