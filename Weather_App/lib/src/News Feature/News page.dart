import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:open_weather_example_flutter/src/News Provider/News Provider.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsProvider()..loadTopHeadlines('general'),
      child: Scaffold(
        appBar: AppBar(
          title: Text('News'),
          backgroundColor: Colors.blue,
        ),
        body: Consumer<NewsProvider>(
          builder: (context, newsProvider, child) {
            if (newsProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (newsProvider.articles.isEmpty) {
              return Center(child: Text('No news available'));
            }

            return ListView.builder(
              itemCount: newsProvider.articles.length,
              itemBuilder: (context, index) {
                final article = newsProvider.articles[index];
                return ListTile(
                  title: Text(article['title']),
                  subtitle: Text(article['description'] ?? 'No description'),
                  onTap: () {
                    // Handle article tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticlePage(article: article),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  final dynamic article;

  const ArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title'] ?? 'No Title'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article['title'] ?? 'No Title',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Text(article['publishedAt'] ?? 'No date available'),
            SizedBox(height: 16),
            Text(article['content'] ?? 'No content available'),
          ],
        ),
      ),
    );
  }
}


