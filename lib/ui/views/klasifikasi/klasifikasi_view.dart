import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'klasifikasi_viewmodel.dart';

class KlasifikasiView extends StatelessWidget {
  const KlasifikasiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<KlasifikasiViewModel>.nonReactive(
      viewModelBuilder: () => KlasifikasiViewModel(),
      builder: (
        BuildContext context,
        KlasifikasiViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          body: Container(
            child: SfPdfViewer.network(
              'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
            ),
          ),
        );
      },
    );
  }
}
