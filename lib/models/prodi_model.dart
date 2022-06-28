import 'package:uuid/uuid.dart';

class ProdiModel {
  final String _id;
  final String nama;
  final String fakultas;

  int jumlahJurnal = 0;
  int bytes = 0;

  ProdiModel({String? id, required this.nama, required this.fakultas})
      : _id = id ?? const Uuid().v4();

  String get id => _id;

  ProdiModel.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        nama = json['nama'],
        fakultas = json['fakultas'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'nama': nama,
        'fakultas': fakultas,
      };

  @override
  String toString() {
    return 'ProdiModel{_id: $_id, nama: $nama, fakultas: $fakultas}';
  }

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return mb > 1
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}
