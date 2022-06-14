import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'pdf_viewmodel.dart';

class PdfView extends StatelessWidget {
  final JurnalModel jurnal;

  const PdfView({Key? key, required this.jurnal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PdfViewModel>.nonReactive(
      viewModelBuilder: () => PdfViewModel(),
      builder: (
        BuildContext context,
        PdfViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(title: Text(jurnal.fileData?.name ?? 'Pdf')),
          backgroundColor: greyThirdColor,
          body: Center(
            child: jurnal.fileData?.url != null
                ? SfPdfViewer.network(
                    jurnal.fileData!.url!,
                  )
                : SfPdfViewer.memory(jurnal.fileData!.data!),
          ),
        );
      },
    );
  }
}
