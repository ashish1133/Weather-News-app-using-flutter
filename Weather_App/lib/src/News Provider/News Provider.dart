import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/News Service/News Service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();
  List<dynamic> _articles = [];
  bool _isLoading = false;

  List<dynamic> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> loadTopHeadlines(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsService.fetchTopHeadlines(category);
    } catch (e) {
      _articles = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
