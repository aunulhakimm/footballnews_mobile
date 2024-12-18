import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:footballnews_mobile/app/routes/app_pages.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Football News",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
