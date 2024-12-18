import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 8, 39, 86), // Warna maroon
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
  actions: [
    IconButton(
      icon: const Icon(Icons.exit_to_app, color: Colors.white),
      onPressed: () {
        // Panggil fungsi logout disini, misalnya menggunakan GetX atau FirebaseAuth
        Get.offAllNamed('/signin'); // Navigasi ke halaman sign-in setelah logout
      },
    ),
  ],
  iconTheme: const IconThemeData(color: Colors.white),
),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150), // Tinggi diubah menjadi 150
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CarouselSlider(
                items: [
                  // Carousel item 1
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 39, 86), // Warna footer untuk carousel
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.info_outline,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Selamat datang di Berita Garuda!\nAplikasi untuk mendapatkan berita terkini!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, // Font warna putih
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Carousel item 2
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 39, 86), // Warna footer untuk carousel
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.menu_book,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Baca berita terkini dari berbagai kategori di halaman Read News.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, // Font warna putih
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Carousel item 3
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 8, 39, 86), // Warna footer untuk carousel
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.play_circle_filled,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Tonton video menarik dan berita terbaru di halaman Watch.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, // Font warna putih
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 400, 
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.75, 
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 8, 39, 86), // Warna lebih gelap untuk footer
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          backgroundColor: const Color.fromARGB(255, 8, 39, 86), // Warna footer lebih gelap
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_filled),
              label: 'Watch',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Read News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
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
