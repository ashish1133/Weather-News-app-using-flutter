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
          title: const Text('News'),
          backgroundColor: Colors.blue,
        ),
        body: Consumer<NewsProvider>(
          builder: (context, newsProvider, child) {
            if (newsProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (newsProvider.articles.isEmpty) {
              return const Center(child: Text('No news available'));
            }

            return ListView.builder(
              itemCount: newsProvider.articles.length,
              itemBuilder: (context, index) {
                final article = newsProvider.articles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: article['urlToImage'] != null
                        ? Image.network(article['urlToImage'], width: 100, fit: BoxFit.cover)
                        : Container(width: 100, color: Colors.grey[200], child: const Icon(Icons.image, color: Colors.grey)),
                    title: Text(article['title'], maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Text(article['description'] ?? 'No description', maxLines: 2, overflow: TextOverflow.ellipsis),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticlePage(article: article),
                        ),
                      );
                    },
                  ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article['urlToImage'] != null
                ? Image.network(article['urlToImage'])
                : Container(color: Colors.grey[200], child: const Icon(Icons.image, color: Colors.grey, size: 100)),
            const SizedBox(height: 16),
            Text(
              article['title'] ?? 'No Title',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              article['publishedAt'] ?? 'No date available',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              article['content'] ?? 'No content available',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
