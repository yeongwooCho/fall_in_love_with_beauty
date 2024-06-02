import 'package:fall_in_love_with_beauty/product/model/result_model.dart';

class DesignerModel {
  final String id;
  final String name;
  final String thumbnail;
  final String mainImageUrl;
  final double ratingPoint;
  final String description;
  final String snsUrl;

  final List<ResultModel> results;

  DesignerModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.mainImageUrl,
    required this.ratingPoint,
    required this.description,
    required this.snsUrl,
    required this.results,
  });

  DesignerModel copyWith({
    String? id,
    String? name,
    String? thumbnail,
    String? mainImageUrl,
    double? ratingPoint,
    String? description,
    String? snsUrl,
    List<ResultModel>? results,
  }) {
    return DesignerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      mainImageUrl: mainImageUrl ?? this.mainImageUrl,
      ratingPoint: ratingPoint ?? this.ratingPoint,
      description: description ?? this.description,
      snsUrl: snsUrl ?? this.snsUrl,
      results: results ?? this.results,
    );
  }
}
