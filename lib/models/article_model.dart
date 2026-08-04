class ArticleModel {
  final String title;
  final String? description;
  final String? imageUrl;

  ArticleModel({
    required this.title,
    this.description,
    this.imageUrl,
  });

  // İnternetdən gələn məlumatı təhlükəsiz şox oxumaq üçün factory
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No Title', // Əgər başlıq yoxdursa, səhv verməsin, 'No Title' yazsın
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'],
    );
  }
}