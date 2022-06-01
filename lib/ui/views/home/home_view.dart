import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/ui/views/home/widgets/sidebar_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

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
        print(Device.screenType);
        print(Device.orientation);
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
                child: model.viewForIndex,
                // child: Container(
                //   height: double.infinity,
                //   width: double.infinity,
                //   color: backgroundColor,
                //   child: Center(child: Text("Home")),
                // ),
              )
            ],
          ),
        );
      },
    );
  }
}
