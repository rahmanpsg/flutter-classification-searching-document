import 'package:pencarian_jurnal/models/classification_report_model.dart';
import 'package:pencarian_jurnal/models/jurnal_model.dart';

class HasilTrainingModel {
  final List<ClassificationReportModel> classificationReports;
  final double score;
  final List<JurnalModel> data;

  HasilTrainingModel({
    required this.classificationReports,
    required this.score,
    required this.data,
  });

  factory HasilTrainingModel.fromJson(Map<String, dynamic> json) {
    return HasilTrainingModel(
      classificationReports:
          (json['classification_report'] as Map<String, dynamic>)
              .entries
              .map((entry) => ClassificationReportModel.fromJson({
                    'kategori': entry.key,
                    ...entry.value,
                  }))
              .toList(),
      score: json['score'],
      data: (json['data'] as List<dynamic>)
          .map((e) => JurnalModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classificationReports': classificationReports,
      'score': score,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'HasilTrainingModel{classificationReports: $classificationReports, score: $score, data: $data}';
  }
}
