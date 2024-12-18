import 'package:flutter/material.dart';
import 'package:footballnews_mobile/app/data/models/category_data.dart';
import 'package:footballnews_mobile/app/data/models/new_model.dart';
import 'package:footballnews_mobile/app/data/services/service.dart';
import 'package:footballnews_mobile/app/modules/readnews/readnews_category.dart';
import 'package:footballnews_mobile/app/modules/readnews/news_detail.dart';
import 'package:get/get.dart'; // Import Get package

class ReadNewsView extends StatefulWidget {
  const ReadNewsView({super.key});

  @override
  _ReadNewsViewState createState() => _ReadNewsViewState();
}

class _ReadNewsViewState extends State<ReadNewsView> {
  List<NewsModel> articles = [];
  List<CategoryModel> categories = [];
  bool isLoading = true;

  getNews() async {
    NewsApi newsApi = NewsApi();
    await newsApi.getNews();
    articles = newsApi.dataStore;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    categories = getCategories();
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      color: const Color.fromARGB(255, 8, 39, 86), // Maroon color for the background
    ),
  ),
  title: Row(
    children: [
      Image.network(
        'https://images.seeklogo.com/logo-png/30/1/indonesia-national-football-logo-png_seeklogo-306122.png?v=638687102030000000',
        height: 40,
        width: 40,
        fit: BoxFit.cover,
      ),
      const SizedBox(width: 10),
      const Text(
        "HOKIBOLA69",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ],
  ),
  centerTitle: true, // Judul berada di tengah
  iconTheme: const IconThemeData(color: Colors.white), // Back button menjadi putih
),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectedCategoryNews(
                                  category: category.categoryName!,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:  Color.fromARGB(255, 8, 39, 86),
                              ),
                              child: Text(
                                category.categoryName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetail(newsModel: article),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  article.urlToImage!,
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                article.title!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const Divider(thickness: 2),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
  color: const Color.fromARGB(255, 8, 39, 86), // Maroon color for footer
  child: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white54,
    backgroundColor: const Color.fromARGB(255, 8, 39, 86), // Maroon color for the background
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.play_circle_filled, color: Colors.white),
        label: 'Watch',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Colors.white),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu_book, color: Colors.white),
        label: 'Read News',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person, color: Colors.white),
        label: 'Profile',
      ),
    ],
    currentIndex: 1, // Sesuaikan index untuk halaman ini
          onTap: (index) {
            if (index == 0) {
              Get.toNamed('/watch'); // Navigasi ke Watch
            } else if (index == 1) {
              Get.toNamed('/home'); // Navigasi ke Home
            } else if (index == 2) {
              Get.toNamed('/readnews'); // Navigasi ke ReadNews
            } else if (index == 3) {
              Get.toNamed('/profile'); // Navigasi ke Profile
            }
          },
  ),
),
    );
  }
}
