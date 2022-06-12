import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:pencarian_jurnal/app/app.logger.dart';
import 'package:pencarian_jurnal/models/file_data_model.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';

class CustomDropZone extends StatefulWidget {
  final ValueChanged<FileDataModel> onDroppedFile;

  const CustomDropZone({
    Key? key,
    required this.onDroppedFile,
  }) : super(key: key);

  @override
  State<CustomDropZone> createState() => _CustomDropZoneState();
}

class _CustomDropZoneState extends State<CustomDropZone> {
  final log = getLogger('CustomDropZone');

  late DropzoneViewController controller;
  late FileDataModel droppedFile;
  // bool isDropped = false;

  Future setFile(dynamic event) async {
    try {
      final name = event.name;
      final mime = await controller.getFileMIME(event);
      final byte = await controller.getFileSize(event);
      final fileData = await controller.getFileData(event);

      log.d('Name : $name');
      log.d('Mime: $mime');
      log.d('Size : ${byte / (1024 * 1024)}');

      // update the data model with recent file uploaded
      droppedFile =
          FileDataModel(name: name, mime: mime, bytes: byte, data: fileData);
      //Update the UI
      widget.onDroppedFile(droppedFile);
    } catch (e) {
      log.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      radius: const Radius.circular(8),
      borderType: BorderType.RRect,
      padding: const EdgeInsets.all(0),
      color: primaryColor,
      dashPattern: const [4, 4],
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 100,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: greyThirdColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child:
            // isDropped
            //     ? Column(
            //         children: <Widget>[
            //           Text(
            //             droppedFile.name,
            //           ),
            //           const SizedBox(height: 8),
            //           const Text(
            //             'File berhasil terupload',
            //           ),
            //         ],
            //       )
            //     :
            Stack(
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
                children: <Widget>[
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
