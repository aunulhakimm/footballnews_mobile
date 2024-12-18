import 'dart:convert';
import 'package:footballnews_mobile/app/data/models/new_model.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  // For fetching news on the home screen
  List<NewsModel> dataStore = [];
  
  Future<void> getNews() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=03ec3b3ffc59472aa0021b9685e8eb76");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['author'] != null &&
            element['content'] != null &&
            element['source'] != null &&
            element['source']['name'] != null) {
          NewsModel newsModel = NewsModel(
            title: element['title'], // Match the key from API
            urlToImage: element['urlToImage'],
            description: element['description'],
            author: element['author'],
            content: element['content'],
          );
          dataStore.add(newsModel);
        }
      });
    }
  }
}

class CategoryNews {
  // For fetching news by category
  List<NewsModel> dataStore = [];
  
  Future<void> getNews(String category) async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=03ec3b3ffc59472aa0021b9685e8eb76");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['author'] != null &&
            element['content'] != null &&
            element['source'] != null &&
            element['source']['name'] != null) {
          NewsModel newsModel = NewsModel(
            title: element['title'], // Match the key from API
            urlToImage: element['urlToImage'],
            description: element['description'],
            author: element['author'],
            content: element['content'],
          );
          dataStore.add(newsModel);
        }
      });
    }
  }
}
