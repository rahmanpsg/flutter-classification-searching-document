import 'dart:typed_data';

class FileDataModel {
  final String name;
  final String mime;
  final int bytes;
  Uint8List? data;
  String? url;
  String? text;

  FileDataModel({
    required this.name,
    required this.mime,
    required this.bytes,
    this.data,
    this.url,
    this.text,
  });

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return mb > 1
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
  }

  FileDataModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        mime = json['mime'],
        bytes = json['bytes'],
        url = json['url'],
        text = json['text'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'mime': mime,
        'bytes': bytes,
        'url': url,
        'text': text,
      };

  @override
  String toString() {
    return 'FileDataModel{name: $name, mime: $mime, bytes: $bytes, url: $url}';
  }
}
