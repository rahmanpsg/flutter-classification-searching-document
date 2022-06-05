import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
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
  late DropzoneViewController controller;

  Future uploadedFile(dynamic event) async {
    // this method is called when user drop the file in drop area in flutter

    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final byte = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    print('Name : $name');
    print('Mime: $mime');
    print('Size : ${byte / (1024 * 1024)}');
    print('URL: $url');

    // update the data model with recent file uploaded
    final droppedFile =
        FileDataModel(name: name, mime: mime, bytes: byte, url: url);
    //Update the UI
    widget.onDroppedFile(droppedFile);
    setState(() {
      // highlight = false;
    });
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
        height: 100,
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
                operation: DragOperation.move,
                cursor: CursorType.grab,
                onCreated: (DropzoneViewController ctrl) => controller = ctrl,
                onLoaded: () => print('Zone loaded'),
                onError: (String? ev) => print('Error: $ev'),
                onHover: () => print('Zone hovered'),
                onDrop: (dynamic ev) => print('Drop: $ev'),
                onDropMultiple: (List<dynamic>? ev) =>
                    print('Drop multiple: $ev'),
                onLeave: () => print('Zone left'),
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
                      uploadedFile(events.first);
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
