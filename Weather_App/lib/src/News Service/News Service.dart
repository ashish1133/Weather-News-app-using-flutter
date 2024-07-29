import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = '57d94a52d5e647589b4bd508db29c911'; // Replace with your API key
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<dynamic>> fetchTopHeadlines(String category) async {
    final url = '$baseUrl/top-headlines?category=$category&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
