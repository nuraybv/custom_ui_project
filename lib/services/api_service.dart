import 'package:dio/dio.dart';
import '../models/article_model.dart';

class ApiService {
  // Dio-nu quraşdırırıq (baza URL)
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/v2/',
    ),
  );

  // Məlumatları çəkən əsas funksiya
  Future<List<ArticleModel>> fetchArticles() async {
    try {
      final response = await _dio.get(
        'everything',
        queryParameters: {
          'q': 'flutter',
          'apiKey': 'BURAYA_OZEH_API_KEY_YAZACAQSAN', // NewsAPI.org-dan aldığın pulsuz açar
        },
      );

      if (response.statusCode == 200) {
        List articlesJson = response.data['articles'] ?? [];
        return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw Exception('Server xətası baş verdi');
      }
    } on DioException catch (e) {
      // İnternet qopanda və ya səhv olanda proqram çökmür, burada tutulur
      throw Exception('İnternet xətası: ${e.message}');
    }
  }
}