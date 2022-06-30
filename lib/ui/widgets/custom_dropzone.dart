import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:pencarian_jurnal/app/app.locator.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/app/app.router.dart';
import 'package:pencarian_jurnal/models/file_data_model.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:pencarian_jurnal/utils/preprocessing.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CustomDropZone extends StatefulWidget {
  final ValueChanged<FileDataModel> onDroppedFile;
  final bool isDroppedShow;
  final double height;

  const CustomDropZone({
    Key? key,
    required this.onDroppedFile,
    this.isDroppedShow = false,
    this.height = 100,
  }) : super(key: key);

  @override
  State<CustomDropZone> createState() => _CustomDropZoneState();
}

class _CustomDropZoneState extends State<CustomDropZone> {
  final log = getLogger('CustomDropZone');

  late DropzoneViewController controller;
  late FileDataModel droppedFile;
  bool isDropped = false;

  Preprocessing preprocessing = Preprocessing();

  Future setFile(dynamic event) async {
    try {
      final name = event.name;
      final mime = await controller.getFileMIME(event);
      final byte = await controller.getFileSize(event);
      final fileData = await controller.getFileData(event);

      log.d('Name : $name');
      log.d('Mime: $mime');
      log.d('Size : ${byte / (1024 * 1024)}');

      //Load an existing PDF document.
      final PdfDocument document = PdfDocument(inputBytes: fileData);
      //Extract the text from all the pages.
      String text = PdfTextExtractor(document).extractText();

      //Dispose the document.
      document.dispose();

      // check text
      if (text.isEmpty) {
        locator<DialogService>().showDialog(
          title: 'Error',
          description: 'File tidak dapat dibaca',
        );
        return;
      }

      String textPreprocessing = await preprocessing.preprocess(text);

      // update the data model with recent file uploaded
      droppedFile = FileDataModel(
          name: name,
          mime: mime,
          bytes: byte,
          data: fileData,
          text: textPreprocessing);
      //Update the UI
      widget.onDroppedFile(droppedFile);

      if (!widget.isDroppedShow) return;

      setState(() {
        isDropped = true;
      });
    } catch (e) {
      log.e(e);
    }
  }

  void toPDFView() {
    locator<NavigationService>().navigateTo(Routes.pdfView,
        arguments:
            PdfViewArguments(jurnal: JurnalModel(fileData: droppedFile)));
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: const Radius.circular(8),
      borderType: BorderType.RRect,
      padding: const EdgeInsets.all(0),
      color: primaryColor,
      dashPattern: const [4, 4],
      child: Container(
        height: widget.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: greyThirdColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Stack(
          children: [
            Builder(builder: (context) {
              return DropzoneView(
                mime: const ['application/pdf'],
                operation: DragOperation.move,
                cursor: CursorType.copy,
                onDrop: setFile,
                onCreated: (DropzoneViewController ctrl) => controller = ctrl,
              );
            }),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: isDropped
                    ? [
                        Text(
                          droppedFile.name,
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: toPDFView,
                          child: Tooltip(
                            message: "Lihat",
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Card(
                                child: Image.network(
                                  "https://img.icons8.com/external-flatart-icons-flat-flatarticons/64/undefined/external-pdf-file-online-learning-flatart-icons-flat-flatarticons.png",
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    : [
                        ElevatedButton(
                          onPressed: () async {
                            final events = await controller.pickFiles(
                              mime: ['application/pdf'],
                            );
                            if (events.isEmpty) return;
                            setFile(events.first);
                          },
                          child: const Text("Pilih file"),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "atau drag file ke sini",
                          style: greyTextStyle,
                        ),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
