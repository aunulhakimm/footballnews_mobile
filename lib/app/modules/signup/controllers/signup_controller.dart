import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  Future<void> signup(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return;
    }

    try {
      isLoading.value = true;

      // Buat User di Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Simpan Data User ke Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Log keberhasilan untuk debugging
      print("User successfully signed up: ${userCredential.user!.uid}");

      // Navigasi ke halaman Signin
      Get.offAllNamed('/signin');
      Get.snackbar('Success', 'Signup successful');
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Auth Error
      String errorMessage = e.message ?? 'Signup failed';
      Get.snackbar('Error', errorMessage);
      print("FirebaseAuth Error: ${e.code} - ${e.message}");
    } catch (e) {
      // Handle General Error
      Get.snackbar('Error', 'An unexpected error occurred');
      print("General Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
