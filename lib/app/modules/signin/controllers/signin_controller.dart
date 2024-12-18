import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';// Pastikan impor ini ada

class SigninController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  Future<void> signin(String email, String password) async {
    try {
      isLoading.value = true;

      // Proses login
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Jika login berhasil
      Get.snackbar(
        'Success',
        'Sign In successful',
        backgroundColor: Colors.green.withOpacity(0.8), // Warna dengan transparansi
        colorText: Colors.white, // Warna teks
        snackPosition: SnackPosition.BOTTOM,
      );

      // Redirect ke Home
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Handling error spesifik
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
      }

      // Tampilkan pesan error
      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Colors.red.withOpacity(0.8), // Warna dengan transparansi
        colorText: Colors.white, // Warna teks
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // Handling error umum
      Get.snackbar(
        'Error',
        'Failed to Sign In. Please try again later.',
        backgroundColor: Colors.red.withOpacity(0.8), // Warna dengan transparansi
        colorText: Colors.white, // Warna teks
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
