class ResultModel {
  final String id;
  final String imageUrl;

  ResultModel({
    required this.id,
    required this.imageUrl,
  });

  ResultModel copyWith({
    String? id,
    String? imageUrl,
  }) {
    return ResultModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
