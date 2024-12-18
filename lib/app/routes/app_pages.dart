import 'package:footballnews_mobile/app/modules/home/bindings/home_binding.dart';
import 'package:footballnews_mobile/app/modules/home/views/home_view.dart';
import 'package:footballnews_mobile/app/modules/profile/bindings/profile_binding.dart';
import 'package:footballnews_mobile/app/modules/profile/views/profile_view.dart';
import 'package:footballnews_mobile/app/modules/readnews/readnews_view.dart';
import 'package:footballnews_mobile/app/modules/watch/bindings/watch_binding.dart';
import 'package:footballnews_mobile/app/modules/watch/views/watch_view.dart';
import 'package:get/get.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNUP;

  static final routes = [
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: Routes.SIGNIN,
      page: () => SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.READNEWS,
      page: () => const ReadNewsView(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(  // Add this page for Watch
      name: Routes.WATCH,
      page: () => WatchView(),
      binding: WatchBinding(),
    ),
  ];
}
