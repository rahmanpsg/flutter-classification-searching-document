import 'package:pencarian_jurnal/models/file_data_model.dart';
import 'package:uuid/uuid.dart';

import 'hasil_tf_idf_model.dart';

class JurnalModel {
  final String _id;
  FileDataModel? fileData;
  String? nama;
  String? nim;
  String? tahun;
  String? prodi;
  double? jarak;
  String? prediksi;
  List<HasilTfIdfModel>? hasilsTfIdf;

  JurnalModel({
    String? id,
    this.fileData,
    this.nama,
    this.nim,
    this.tahun,
    this.prodi,
    this.jarak,
    this.prediksi,
    this.hasilsTfIdf,
  }) : _id = id ?? const Uuid().v4();

  String get id => _id;

  JurnalModel.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        fileData = json['fileData'] != null
            ? FileDataModel.fromJson(json['fileData'])
            : null,
        nama = json['nama'],
        nim = json['nim'],
        tahun = json['tahun'],
        prodi = json['prodi'],
        jarak = json['jarak'],
        prediksi = json['prediksi'],
        hasilsTfIdf = json['hasil_tfidf'] != null
            ? (json['hasil_tfidf'] as List)
                .map((e) => HasilTfIdfModel.fromJson(e))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': _id,
        'fileData': fileData?.toJson(),
        'nama': nama,
        'nim': nim,
        'tahun': tahun,
        'prodi': prodi,
      };

  @override
  String toString() {
    return 'JurnalModel{_id: $_id, _fileData: $fileData, _nama: $nama, _nim: $nim, _tahun: $tahun, _prodi: $prodi}';
  }

  bool get isValid =>
      fileData != null &&
      nama != null &&
      nim != null &&
      tahun != null &&
      prodi != null;
}
