import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/app/app.router.dart';
import 'package:pencarian_jurnal/ui/views/home/widgets/sidebar_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: Device.screenType == ScreenType.tablet,
                child: const Flexible(child: SideBar()),
              ),
              Expanded(
                flex: Device.orientation == Orientation.landscape ? 7 : 3,
                // child: model.viewForIndex,
                child: ExtendedNavigator(
                  router: HomeViewRouter(),
                  navigatorKey: StackedService.nestedNavigationKey(0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
