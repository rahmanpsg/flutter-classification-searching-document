import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'pencarian_viewmodel.dart';

class PencarianView extends StatelessWidget {
  const PencarianView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PencarianViewModel>.nonReactive(
      viewModelBuilder: () => PencarianViewModel(),
      builder: (
        BuildContext context,
        PencarianViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'PencarianView',
            ),
          ),
        );
      },
    );
  }
}
