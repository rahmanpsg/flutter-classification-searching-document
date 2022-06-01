import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_card.dart';
import 'package:pencarian_jurnal/ui/widgets/custom_stats.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.nonReactive(
      viewModelBuilder: () => DashboardViewModel(),
      builder: (
        BuildContext context,
        DashboardViewModel model,
        Widget? child,
      ) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              CustomCard(
                title: "Halo, Selamat malam!",
                subtitle:
                    "Selamat datang di aplikasi klasifikasi dan pencarian jurnal",
                child: Responsive(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 8,
                  children: <Widget>[
                    Div(
                      colL: 4,
                      colS: 12,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: CustomStats(
                          icon: Ionicons.document,
                          title: "10",
                          subtitle: "Total Jurnal",
                        ),
                      ),
                    ),
                    Div(
                      colL: 4,
                      colS: 12,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: CustomStats(
                          color: secondaryColor,
                          icon: Ionicons.document,
                          title: "10",
                          subtitle: "Total Jurnal",
                        ),
                      ),
                    ),
                    Div(
                      colL: 4,
                      colS: 12,
                      child: const CustomStats(
                        icon: Ionicons.document,
                        title: "10",
                        subtitle: "Total Jurnal",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CustomCard(
                subtitle: "Populer Jurnal",
                child: Responsive(
                  runSpacing: 8,
                  children: <Widget>[
                    for (int i = 0; i < 100; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: 100,
                                color: greySecondaryColor,
                              ),
                              const Text("Abd Rahman", style: boldTextStyle),
                              const Text(
                                "Sistem Informasi Inventaris Laboratorium UM-Pare",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
